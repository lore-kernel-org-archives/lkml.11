Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30E5C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 08:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbiBXI2H (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 03:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiBXI1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 03:27:51 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C1C276D55
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 00:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645691242; x=1677227242;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Paj+PVU8PyJGIYoAxp11AHhEJljU2nyKWuT2Y0DSDg8=;
  b=DJYbo8n6SstVsKdRYKt3Od5JJRC21pXginpKqmOPOmq0TCsOhIXWnbTZ
   N6AwiV4kvTe9sdF7QOHk9kyMOTl2YEwIBLLjbuPJ6vEbZBYJO26enWRG0
   0f9UaPd/HnBkPMzAF3TtzH/noqCuat2hB2q6DN52a+TEzIrgY20vLxBey
   Q=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 Feb 2022 00:27:22 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 00:27:21 -0800
Received: from hu-rbankapu-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 24 Feb 2022 00:27:19 -0800
From:   Raghu Bankapur <quic_rbankapu@quicinc.com>
To:     Vinod Koul <vkoul@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
CC:     Krishna Jha <quic_kkishorj@quicinc.com>,
        Raghu Bankapur <quic_rbankapu@quicinc.com>
Subject: [PATCH V1 0/1] ASoC: compress: propagate the error code from the
Date:   Thu, 24 Feb 2022 13:56:53 +0530
Message-ID: <cover.1645689841.git.quic_rbankapu@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20220224082653.0EE1gO8yrhIiJxOYWRJeigGu8M6mxndIWjzHnBf6tzY@z>

Propagate the error code from the compress framework for the timestamp
query. This error code will be used by the client to handle the
error case scenarios gracefully.

This propgated error is used by direct client like Audio HAL through
IOCTL -SNDRV_COMPRESS_TSTAMP response, further this response is sent
to upper layer, based on this error audio related usecases related 
to render position and presentation are handled.

Raghu Bankapur (1):
  ASoC: compress: propagate the error code from the compress framework

 sound/core/compress_offload.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.17.1

