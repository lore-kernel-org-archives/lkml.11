Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1248DCCA483
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 22:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383530AbiFGWkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 18:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378037AbiFGV1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:27:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D66228F58;
        Tue,  7 Jun 2022 12:02:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCD1961787;
        Tue,  7 Jun 2022 19:02:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59FBC385A2;
        Tue,  7 Jun 2022 19:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654628526;
        bh=YmN4V4yALByetjoXbl5eqlLA/g/d1ZKfNiLnROwqz3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nTh64IONyhJyhQABu0u5fViMtdx550FSXrU4IeY0V3s3XCpJrFym2SIgUDUi/6rbM
         xj6E4nBZ8yqRM4QqXuNeM/hGpVA5IW5kwViteKMQCOTP39jvVxld8MXN0bRt8p6YpG
         nOZ1gFNOa6S7INUsPM829z+Er9yqrx6mAhoCeO9U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.18 360/879] libbpf: Fix logic for finding matching program for CO-RE relocation
Date:   Tue,  7 Jun 2022 18:57:58 +0200
Message-Id: <20220607165013.313188641@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607165002.659942637@linuxfoundation.org>
References: <20220607165002.659942637@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 966a7509325395c51c5f6d89e7352b0585e4804b ]

Fix the bug in bpf_object__relocate_core() which can lead to finding
invalid matching BPF program when processing CO-RE relocation. IF
matching program is not found, last encountered program will be assumed
to be correct program and thus error detection won't detect the problem.

Fixes: 9c82a63cf370 ("libbpf: Fix CO-RE relocs against .text section")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/bpf/20220426004511.2691730-4-andrii@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/libbpf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 7af6805a863d..881ea905ca81 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -5646,9 +5646,10 @@ bpf_object__relocate_core(struct bpf_object *obj, const char *targ_btf_path)
 		 */
 		prog = NULL;
 		for (i = 0; i < obj->nr_programs; i++) {
-			prog = &obj->programs[i];
-			if (strcmp(prog->sec_name, sec_name) == 0)
+			if (strcmp(obj->programs[i].sec_name, sec_name) == 0) {
+				prog = &obj->programs[i];
 				break;
+			}
 		}
 		if (!prog) {
 			pr_warn("sec '%s': failed to find a BPF program\n", sec_name);
-- 
2.35.1



