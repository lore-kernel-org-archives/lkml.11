Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812D1C19F2A
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Aug 2022 03:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiHGDlO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Aug 2022 23:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiHGDlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 23:41:11 -0400
Received: from n169-112.mail.139.com (n169-112.mail.139.com [120.232.169.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F48CE1B
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 20:41:08 -0700 (PDT)
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[61.152.201.158])
        by rmsmtp-lg-appmail-20-12023 (RichMail) with SMTP id 2ef762ef344d672-8c4ae;
        Sun, 07 Aug 2022 11:41:04 +0800 (CST)
X-RM-TRANSID: 2ef762ef344d672-8c4ae
From:   Kevin Lu <luminlong@139.com>
To:     broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, shenghao-ding@ti.com,
        kevin-lu@ti.com, Kevin Lu <luminlong@139.com>
Subject: [PATCH v1 0/1]
Date:   Sun,  7 Aug 2022 11:40:51 +0800
Message-Id: <20220807034052.2314-1-luminlong@139.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*** BLURB HERE ***

Kevin Lu (1):
  drivers: Modify some parts

 tlv320adcx140.c | 114 ++++++++++++++++++++++++++++++++++++------------
 tlv320adcx140.h |   7 +--
 2 files changed, 90 insertions(+), 31 deletions(-)

-- 
2.17.1


