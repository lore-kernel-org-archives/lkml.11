Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B66EC43217
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 09:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344136AbiDEJmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 05:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236123AbiDEIQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:16:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AEB56232;
        Tue,  5 Apr 2022 01:03:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 625C5B81BAF;
        Tue,  5 Apr 2022 08:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2958C385A1;
        Tue,  5 Apr 2022 08:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649145817;
        bh=onA6pjFl4sGyX7aN0bk3e/nopEzBC79EIVPhBS9axjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ad1AbMUZsskXiGEgDTfcMI5izLOOWNBmrNMElmPw6Dr0hU2pZ4zEV1STgZaIDj00I
         h4SHQzAWle+CRcgWQfWWiYou49b8xsumS12CKs28EnNnyFul2Yb8j5jmpPRrNJZLLq
         yTKHKZ1SPQtnnS1MGl4jI4elf02rY+IJObjzzEpo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 0539/1126] libbpf: Fix libbpf.map inheritance chain for LIBBPF_0.7.0
Date:   Tue,  5 Apr 2022 09:21:26 +0200
Message-Id: <20220405070423.453075461@linuxfoundation.org>
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

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit d130e954a002b901391037c33b9ae11bae5aaa91 ]

Ensure that LIBBPF_0.7.0 inherits everything from LIBBPF_0.6.0.

Fixes: dbdd2c7f8cec ("libbpf: Add API to get/set log_level at per-program level")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/bpf/20220211205235.2089104-1-andrii@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/libbpf.map | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 529783967793..9a89fdfe4987 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -431,4 +431,4 @@ LIBBPF_0.7.0 {
 		libbpf_probe_bpf_map_type;
 		libbpf_probe_bpf_prog_type;
 		libbpf_set_memlock_rlim_max;
-};
+} LIBBPF_0.6.0;
-- 
2.34.1



