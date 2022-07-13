Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A974BCCA47C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jul 2022 21:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237343AbiGMVVl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jul 2022 17:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237519AbiGMVVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 17:21:20 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E917341D2E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:20:44 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-10c0430e27dso160375fac.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=exmdB7c9xptB9hfLmXKMVkL6fi2efRwG/lthsovYPhM=;
        b=R3YdxpYpkChwa6YvYqI40BCp7l+FRmsvwW+P7+e3hzwikBwIY5qNQGyuedNhiFMa7V
         MNyx5EuM2fTqwGWecFo/vfak7eMuEkuc3LXfY6FIfI+3/vazOm+j54Rsqz9PfzUE2Ojd
         Rv475j93d4x0xBkYTA5jx9R2a+97t+k+eDidY/sjq3lSPsDoMtJbpjwXakVXyMHM6BmG
         hqKQy1AuuQ6jMSR/ewvOgA2uof3rLVzWhOBiw8bqKlmRIzYEQBScFpQ00CFw7xHgdA0B
         34ifwDFu41OIevPDxEn79Z2YbBGsNDw4ksVdW2X75kwWNOlK7FLZSJkGpnj9WZXWqao8
         Y9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=exmdB7c9xptB9hfLmXKMVkL6fi2efRwG/lthsovYPhM=;
        b=6MkvTZwt9uBilkpDTmxtAy8KcvLyZUf6k6KvWGwK+IgbatJkKo6Yf9GTlufpUmjedr
         z/FGmpL0kQNv1H10hfmgKPPHBtBpz7KUr/KClsN0NnEkABiU3AHHWjwVXKxBlYCyx7an
         8Oi2NmSegZUstwsHmep0s6PF1IIkRBhpodDMmNREPpIOkclHQ52fByKdwB/dgHK/kRg5
         +9s0GKB7Q2KEjGn90cbor11fpsDoMTVY//9JP6UnkSWwNYuxOdMWMdQGoJ7tcM/c86eE
         rcJdLSwO9xgMlWUFxGApi3UAmF/0mf/56MXNI2FLu2if6g3psS8k/qfRGLVVy4mmn3TV
         VRew==
X-Gm-Message-State: AJIora+TCrb17iF1nr59GhEtBoVcchM6GCPuUI78teT1wsQToTQpfjdl
        z/5h3zpeS7sL8N68+jo4EH4E6w==
X-Google-Smtp-Source: AGRyM1uyQj2oM5eqtgnoXoSRm3llUXapZF4C/FLqP1xwBQq7C/sDz2DL8IF8JNxK2ueYlkJwpfiGzg==
X-Received: by 2002:a05:6870:64a8:b0:10c:fe1:6528 with SMTP id cz40-20020a05687064a800b0010c0fe16528mr2876128oab.6.1657747244157;
        Wed, 13 Jul 2022 14:20:44 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id i19-20020a056871029300b0010c17e6c699sm6647897oae.47.2022.07.13.14.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 14:20:43 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Luca Weiss <luca@z3ntu.xyz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] ARM: dts: qcom: msm8974-sony: Enable RGB LED
Date:   Wed, 13 Jul 2022 14:23:07 -0700
Message-Id: <20220713212309.130230-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the Light Pulse Generator block in the pm8941 and use this to
describe the RGB LED driven by the triled in this block.

Bjorn Andersson (2):
  ARM: dts: qcom: Add LPG node to pm8941
  ARM: dts: qcom: msm8974-sony: Enable LPG

 .../dts/qcom-msm8974-sony-xperia-rhine.dtsi   | 30 +++++++++++++++++++
 ...-msm8974pro-sony-xperia-shinano-castor.dts | 30 +++++++++++++++++++
 arch/arm/boot/dts/qcom-pm8941.dtsi            | 10 +++++++
 3 files changed, 70 insertions(+)

-- 
2.35.1

