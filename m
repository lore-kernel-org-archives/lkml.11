Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5004C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jan 2022 17:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbiATR4N (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jan 2022 12:56:13 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:37138 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233102AbiATR4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:56:06 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20K5Ip9w022340;
        Thu, 20 Jan 2022 11:55:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=/IA9aYK9SVb9BvHEuwQJnvbzmEGlO38e5B5sMd74PEs=;
 b=CbICzOYPKbjJcZ5Y39rvRaJd5MksGxO26iFQxXR509EmiVXIc2oEptleua5XaDz9lWpy
 mbEf8qkke+5KTppMduYiSCw8JvPRTiokkaw0vw4CmKuMBRW3xLrU1KoHw3CFdHOlHd5b
 wptJiq9DKmu1AoP6TCFK8k85poc7hpONOHOar79Mu3/GHSYHWG1o1l2Pxh4UhnUcxS52
 9Cd8twaMYLTf2lANJxVJq/Y+tmje9S7oq6Umv7tH7/aZnHMqeRuQcEPOd0CyBc4YLRiW
 JQkrp0R6O2muqc7RJ8VBpZGtttB84rjjokFf2OXtrBkI1D5DCpHZo8WZbRg5DVadcR8n rw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3dpms0hh17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 20 Jan 2022 11:55:57 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 20 Jan
 2022 17:55:53 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 20 Jan 2022 17:55:53 +0000
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.33])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 35050B13;
        Thu, 20 Jan 2022 17:55:53 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 0/3] ASOC: cs42l42: Add support for system suspend
Date:   Thu, 20 Jan 2022 17:55:46 +0000
Message-ID: <20220120175549.671831-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -0qIb_fGy_rUEMofCkMELgRt3ynZ0UbZ
X-Proofpoint-GUID: -0qIb_fGy_rUEMofCkMELgRt3ynZ0UbZ
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add system suspend and resume handlers so that the cs42l42 is cleanly
put into power-off state during system suspend and the registers are
restored in resume.

The first two patches separate out two small changes that can stand
alone and are needed to enable the system suspend implementation:

1) Don't rely on there being a jack unplug IRQ before a plug IRQ.
There won't be if the unplug and plug happened while in system suspend.

2) Put a mutex around the entire IRQ handling so that the suspend can
ensure the last run of the IRQ handler has completed before it powers
down.

Richard Fitzgerald (3):
  ASoC: cs42l42: Report full jack status when plug is detected
  ASoC: cs42l42: Change jack_detect_mutex to a lock of all IRQ handling
  ASoC: cs42l42: Handle system suspend

 sound/soc/codecs/cs42l42.c | 164 ++++++++++++++++++++++++++++++++++++++++++---
 sound/soc/codecs/cs42l42.h |   7 +-
 2 files changed, 161 insertions(+), 10 deletions(-)

-- 
2.11.0

