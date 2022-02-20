Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47629C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Feb 2022 20:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244857AbiBTUUS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Feb 2022 15:20:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239590AbiBTUUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 15:20:06 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1614C781;
        Sun, 20 Feb 2022 12:19:45 -0800 (PST)
Received: from localhost.localdomain (ip-213-127-118-180.ip.prioritytelecom.net [213.127.118.180])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 88C08C83E2;
        Sun, 20 Feb 2022 20:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1645388384; bh=pevT5ngeMdEGKhS+LQM1Uf8pYfWyYgYcJQdxm+iFLxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=tBTvB/F/jedRx7dbEugIXV5x/G7I1x4AYHltzPIjguQAr2/DvPyrJi0++4YJwmree
         EJ4z9wB34+zEfRtk54DPNr2w9qA2uR9jvD5yB8fI/n/1o3MQTDaITmYZGLF2NUZy3B
         O1d7TzM3YTbDJL4w4dFKWBmO9DRl8s4iUsj3G8RU=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Stephan Gerhold <stephan@gerhold.net>,
        Hector Martin <marcan@marcan.st>,
        Bartosz Dudziak <bartosz.dudziak@snejp.pl>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/10] dt-bindings: arm: cpus: Add Kryo 250 CPUs
Date:   Sun, 20 Feb 2022 21:18:57 +0100
Message-Id: <20220220201909.445468-5-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220220201909.445468-1-luca@z3ntu.xyz>
References: <20220220201909.445468-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Kryo 250 CPUs found in Qualcomm Snapdragon 632 (SDM632).

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v2:
- new patch

 Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 916a5aebefff..85a31ca862d0 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -173,6 +173,7 @@ properties:
       - nvidia,tegra194-carmel
       - qcom,krait
       - qcom,kryo
+      - qcom,kryo250
       - qcom,kryo260
       - qcom,kryo280
       - qcom,kryo385
-- 
2.35.1

