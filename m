Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD965C4167D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 09:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236912AbiDEJDq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 05:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237390AbiDEIR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:17:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BD4B53F5;
        Tue,  5 Apr 2022 01:06:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EEE39B81A32;
        Tue,  5 Apr 2022 08:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51451C385A0;
        Tue,  5 Apr 2022 08:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649145969;
        bh=yjGmY8fE2gNy+34hXTdeIbHMJGLxylssHADL0OpCWeI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qhBgsmoWPJERMB6X/yeTRW3GyMQpPFMNnZd+qlJzfJbJ6bPcasV3L/+rIUp1EtQM1
         r6VGS1IZvjxygSbhnKV6m8eOvld2BQAUXhipWQ4osZ63KO2DjQLiFpVaqTbp0rSLN2
         9+h5xc71huE6ciCegk6WLmKuOHOPl/esDNzZyd40=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yinjun Zhang <yinjun.zhang@corigine.com>,
        Simon Horman <simon.horman@corigine.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
        Jiri Olsa <jolsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 0547/1126] bpftool: Fix the error when lookup in no-btf maps
Date:   Tue,  5 Apr 2022 09:21:34 +0200
Message-Id: <20220405070423.688699213@linuxfoundation.org>
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

From: Yinjun Zhang <yinjun.zhang@corigine.com>

[ Upstream commit edc21dc909c6c133a2727f063eadd7907af51f94 ]

When reworking btf__get_from_id() in commit a19f93cfafdf the error
handling when calling bpf_btf_get_fd_by_id() changed. Before the rework
if bpf_btf_get_fd_by_id() failed the error would not be propagated to
callers of btf__get_from_id(), after the rework it is. This lead to a
change in behavior in print_key_value() that now prints an error when
trying to lookup keys in maps with no btf available.

Fix this by following the way used in dumping maps to allow to look up
keys in no-btf maps, by which it decides whether and where to get the
btf info according to the btf value type.

Fixes: a19f93cfafdf ("libbpf: Add internal helper to load BTF data by FD")
Signed-off-by: Yinjun Zhang <yinjun.zhang@corigine.com>
Signed-off-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Reviewed-by: Niklas Söderlund <niklas.soderlund@corigine.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/bpf/1644249625-22479-1-git-send-email-yinjun.zhang@corigine.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/bpftool/map.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index c66a3c979b7a..7a341a472ea4 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -1054,11 +1054,9 @@ static void print_key_value(struct bpf_map_info *info, void *key,
 	json_writer_t *btf_wtr;
 	struct btf *btf;
 
-	btf = btf__load_from_kernel_by_id(info->btf_id);
-	if (libbpf_get_error(btf)) {
-		p_err("failed to get btf");
+	btf = get_map_kv_btf(info);
+	if (libbpf_get_error(btf))
 		return;
-	}
 
 	if (json_output) {
 		print_entry_json(info, key, value, btf);
-- 
2.34.1



