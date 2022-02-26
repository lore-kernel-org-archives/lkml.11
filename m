Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38610C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Feb 2022 18:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbiBZSKU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Feb 2022 13:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiBZSKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 13:10:18 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923D3483B7;
        Sat, 26 Feb 2022 10:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645898984; x=1677434984;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=FQfWBCeIW1a+N9lwVV1LJBMV0dL7okPKEQ3y6MfBCYg=;
  b=AgKsuO0EuatIvJtuEgjG/ApyC+BbOKYq6aypZCGQxpeQ9dZ7lBnGz4v2
   rLN/a2M+yiMhKlIx6H0WZStDTbRmKrtwTZ9Sneumicfj3v8tzlviU2xjX
   UbJBiHsCF8Xrp8LKxpNtgMaPPVSYQk0nhKfx46kwKd/tYK1JY55EmBcDh
   o=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 26 Feb 2022 10:09:44 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 10:09:42 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sat, 26 Feb 2022 10:09:42 -0800
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sat, 26 Feb 2022 10:09:37 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@codeaurora.org>,
        <perex@perex.cz>, <tiwai@suse.com>,
        <srinivas.kandagatla@linaro.org>, <rohitkr@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH v5 0/2] Add power domains support for digital macro codecs
Date:   Sat, 26 Feb 2022 23:39:17 +0530
Message-ID: <1645898959-11231-1-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to add power domains support for RX, TX and VA macros.

Changes since v4:
    -- Fix uninitialized variable return error
Changes since v3:
    -- Add dt-bindings support.
Changes since v2:
    -- Remove redundant local variable.
    -- Update pds error handling sequence.
    -- Update module description.
    -- Clean up pds init function.
    -- Remove redundant arguments.
Changes since v1:
    -- Add missing macros in Kconfig.

Srinivasa Rao Mandadapu (2):
  ASoC: codecs: Add power domains support in digital macro codecs
  ASoC: qcom: dt-bindings: Add bindings for power domains in lpass
    digital codecs

 .../bindings/sound/qcom,lpass-rx-macro.yaml        |  8 +++
 .../bindings/sound/qcom,lpass-tx-macro.yaml        |  8 +++
 .../bindings/sound/qcom,lpass-va-macro.yaml        |  8 +++
 sound/soc/codecs/Kconfig                           |  7 +++
 sound/soc/codecs/Makefile                          |  2 +
 sound/soc/codecs/lpass-macro-common.c              | 67 ++++++++++++++++++++++
 sound/soc/codecs/lpass-macro-common.h              | 17 ++++++
 sound/soc/codecs/lpass-rx-macro.c                  | 10 +++-
 sound/soc/codecs/lpass-tx-macro.c                  |  9 +++
 sound/soc/codecs/lpass-va-macro.c                  | 10 ++++
 sound/soc/qcom/Kconfig                             |  1 +
 11 files changed, 146 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/codecs/lpass-macro-common.c
 create mode 100644 sound/soc/codecs/lpass-macro-common.h

-- 
2.7.4

