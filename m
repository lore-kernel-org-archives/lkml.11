Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5EBC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 14:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245201AbiDNOIA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 10:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343999AbiDNNaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:30:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B77A986E9;
        Thu, 14 Apr 2022 06:25:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 36C50B82987;
        Thu, 14 Apr 2022 13:25:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D54C385A5;
        Thu, 14 Apr 2022 13:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649942749;
        bh=j8Z1AGKCrXLPe5aJkAu8+ZcWS3IjivjKQItxwfZOl4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FkgJOiBxXGnCsfamyXjiYCGEWEAhoG5aRsXGesCtW7cG+/2/cgH3AwUfXQJKTyr14
         5s6q+QPlQRrypHmcHaXqg96guAs0yQzpePKz+WTMUSPE5W2yxhE8ksSui4r32349O+
         kBxTfwWcQ5abpW/p6V791GP8fe7nS4vl1pjuP5Uk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hengqi Chen <hengqi.chen@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>
Subject: [PATCH 4.19 248/338] bpf: Fix comment for helper bpf_current_task_under_cgroup()
Date:   Thu, 14 Apr 2022 15:12:31 +0200
Message-Id: <20220414110845.950753605@linuxfoundation.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220414110838.883074566@linuxfoundation.org>
References: <20220414110838.883074566@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hengqi Chen <hengqi.chen@gmail.com>

commit 58617014405ad5c9f94f464444f4972dabb71ca7 upstream.

Fix the descriptions of the return values of helper bpf_current_task_under_cgroup().

Fixes: c6b5fb8690fa ("bpf: add documentation for eBPF helpers (42-50)")
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Yonghong Song <yhs@fb.com>
Link: https://lore.kernel.org/bpf/20220310155335.1278783-1-hengqi.chen@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/uapi/linux/bpf.h       |    4 ++--
 tools/include/uapi/linux/bpf.h |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1207,8 +1207,8 @@ union bpf_attr {
  * 	Return
  * 		The return value depends on the result of the test, and can be:
  *
- *		* 0, if current task belongs to the cgroup2.
- *		* 1, if current task does not belong to the cgroup2.
+ *		* 1, if current task belongs to the cgroup2.
+ *		* 0, if current task does not belong to the cgroup2.
  * 		* A negative error code, if an error occurred.
  *
  * int bpf_skb_change_tail(struct sk_buff *skb, u32 len, u64 flags)
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1205,8 +1205,8 @@ union bpf_attr {
  * 	Return
  * 		The return value depends on the result of the test, and can be:
  *
- *		* 0, if current task belongs to the cgroup2.
- *		* 1, if current task does not belong to the cgroup2.
+ *		* 1, if current task belongs to the cgroup2.
+ *		* 0, if current task does not belong to the cgroup2.
  * 		* A negative error code, if an error occurred.
  *
  * int bpf_skb_change_tail(struct sk_buff *skb, u32 len, u64 flags)


