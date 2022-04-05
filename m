Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF33C46467
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 09:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244379AbiDEJlQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 05:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239082AbiDEITq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:19:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD199762B7;
        Tue,  5 Apr 2022 01:10:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C19CB81A37;
        Tue,  5 Apr 2022 08:10:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCEAFC385A0;
        Tue,  5 Apr 2022 08:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649146208;
        bh=KkqvdNudypKbbtIijKOGeT0cNlIeNDr+yKjHsjcNilc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ce+fQXlk+XwcuGazr/9XkyR1+1LLy8fu3AkLgo5A/+xDxsy5vjDpTQ1tldyiH10Lw
         SMXue1zAtGkWSKcTc5qExH9J6zsu3sF4OTC5L9xwTUe2Nos2TV3T+6C536BE/NNs6w
         qmQELzLxy8I1pHkcOWMYvIw3rhodBU8ftxUSRoRQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 0682/1126] selftests/bpf: Fix error reporting from sock_fields programs
Date:   Tue,  5 Apr 2022 09:23:49 +0200
Message-Id: <20220405070427.637224947@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070407.513532867@linuxfoundation.org>
References: <20220405070407.513532867@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Sitnicki <jakub@cloudflare.com>

[ Upstream commit a4c9fe0ed4a13e25e43fcd44d9f89bc19ba8fbb7 ]

The helper macro that records an error in BPF programs that exercise sock
fields access has been inadvertently broken by adaptation work that
happened in commit b18c1f0aa477 ("bpf: selftest: Adapt sock_fields test to
use skel and global variables").

BPF_NOEXIST flag cannot be used to update BPF_MAP_TYPE_ARRAY. The operation
always fails with -EEXIST, which in turn means the error never gets
recorded, and the checks for errors always pass.

Revert the change in update flags.

Fixes: b18c1f0aa477 ("bpf: selftest: Adapt sock_fields test to use skel and global variables")
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Link: https://lore.kernel.org/bpf/20220317113920.1068535-2-jakub@cloudflare.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/progs/test_sock_fields.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_sock_fields.c b/tools/testing/selftests/bpf/progs/test_sock_fields.c
index 81b57b9aaaea..7967348b11af 100644
--- a/tools/testing/selftests/bpf/progs/test_sock_fields.c
+++ b/tools/testing/selftests/bpf/progs/test_sock_fields.c
@@ -113,7 +113,7 @@ static void tpcpy(struct bpf_tcp_sock *dst,
 
 #define RET_LOG() ({						\
 	linum = __LINE__;					\
-	bpf_map_update_elem(&linum_map, &linum_idx, &linum, BPF_NOEXIST);	\
+	bpf_map_update_elem(&linum_map, &linum_idx, &linum, BPF_ANY);	\
 	return CG_OK;						\
 })
 
-- 
2.34.1



