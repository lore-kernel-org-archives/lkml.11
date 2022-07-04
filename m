Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11D8C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Jul 2022 11:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbiGDLlp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Jul 2022 07:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiGDLlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:41:42 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F96199
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 04:41:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=carlo.bai@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VILSmoj_1656934895;
Received: from localhost(mailfrom:carlo.bai@linux.alibaba.com fp:SMTPD_---0VILSmoj_1656934895)
          by smtp.aliyun-inc.com;
          Mon, 04 Jul 2022 19:41:38 +0800
From:   Kaihao Bai <carlo.bai@linux.alibaba.com>
To:     ebiederm@xmission.com
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        baolin.wang@linux.alibaba.com, carlo.bai@linux.alibaba.com
Subject: [PATCH 0/2] kexec: accumulate and release the size of crashkernel
Date:   Mon,  4 Jul 2022 19:41:33 +0800
Message-Id: <1656934895-12334-1-git-send-email-carlo.bai@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently x86 and arm64 support to reserve low memory range for
crashkernel. When crashkernel=Y,low is defined, the main kernel would
reserve another memblock (instead of crashkernel=X,high, which stored
in crashk_res) for crashkernel and store it in crashk_low_res.

The implementations of get_crash_size and crash_shrink_size do not
consider the extra reserved memory range if it exists. Thus, firstly
accumulate this range on the size of crashkernel and export the size 
by /sys/kernel/kexec_crash_size.

If getting the input of /sys/kernel/kexec_crash_size, both reserved ranges
might be released if the new size is smaller than current size. The order
of release is (crashk_res -> crashk_low_res). Only if the new size defined
by the user is smaller than the size of low memory range, continue to 
release the reserved low memory range after completely releasing the high 
memory range.

Kaihao Bai (2):
  kexec: accumulate kexec_crash_size if crashk_low_res defined
  kexec: release reserved memory ranges to RAM if crashk_low_res defined

 kernel/kexec_core.c | 77 ++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 58 insertions(+), 19 deletions(-)

-- 
1.8.3.1

