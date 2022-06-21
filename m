Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D832C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jun 2022 13:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbiFUNxI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jun 2022 09:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiFUNxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 09:53:07 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB44DB86C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 06:53:02 -0700 (PDT)
X-QQ-mid: bizesmtp67t1655819506trl0s0j1
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 21:51:42 +0800 (CST)
X-QQ-SSF: 0100000000700060B000D00A0000000
X-QQ-FEAT: wW02ejDrK1/ZlAO8EkXaEOVfFmvXqewCEGzogin1XrM0pJSkAuwU8347Hou52
        wQ1/NhiC9ypi0H7JWkWQ7ma8RbtxYRM+Yo+8KnBPlMWLz1Kw9uGc9Ud+wTzNDF4Skoyicfa
        flG1qYiZzlwWDVLOKrtpyfMbU5z8Jl2o4xkyBFa+kob5+SrEjq7SMvSTAGYJV4zUK/UKASA
        aXlG6gA5CM7emAdrv/8PA7BQReTYUs+DT22Ywj5aBMQh9e3+E4Y0E+yW+IJ+CpFLJ4W3I9n
        RAKyy8zRdmnyHERN7/MG4zZSGjj1rrqG0vCsfIFPpoQ0h0R7I0DD+las4na5/uaurfP6qTh
        VdrkVbyhYmytG13BuNa7lZmb4PXPkhuaW5CSYN7
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] GPU: drm: drop unexpected word "the" in the comments
Date:   Tue, 21 Jun 2022 21:51:40 +0800
Message-Id: <20220621135140.12200-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word "the" in the comments that need to be dropped

file: drivers/gpu/drm/drm_ioctl.c
line: 86
*    means the the unique name for the master node just opening is _not_ filled
changed to
*    means the unique name for the master node just opening is _not_ filled

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/gpu/drm/drm_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index 51fcf1298023..8faad23dc1d8 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -83,7 +83,7 @@
  *
  * 1. Directly call VERSION to get the version and to match against the driver
  *    name returned by that ioctl. Note that SET_VERSION is not called, which
- *    means the the unique name for the master node just opening is _not_ filled
+ *    means the unique name for the master node just opening is _not_ filled
  *    out. This despite that with current drm device nodes are always bound to
  *    one device, and can't be runtime assigned like with drm 1.0.
  * 2. Match driver name. If it mismatches, proceed to the next device node.
-- 
2.17.1

