Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62872C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 May 2022 02:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239183AbiEEC31 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 May 2022 22:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239298AbiEEC3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 22:29:03 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF8E13D41
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 19:25:25 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id q8so3041496oif.13
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 19:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=moa0rcMvLHKuxdxI1h9ylYwMNI93SZwQx2b51rTmovE=;
        b=i9CKkmhIDyV9nMEWjRJ0TwdW2E5CkkbK6as+LIP4sG4W+z6CORxIJahsKGWUaOj2yZ
         VUruWYYQsSUutj5oHqEQoaX2jl5zdC4BwScNcy1RO9RvjpCY7FAfTveQ5hn8PrvonE+s
         hN4tolMPih77TlYlBXRd3+jSSfS7Iwm9YCa4LTXl01F3S6MxCkEhErPLI9gGRH238/ZR
         YFI3ALEuCdtRPkior2pllYVXU6Hy/ZbZ4s3+qlNO4GPkdof05oxrWr7EUygmqtu9uNzA
         0ApIzXiEdoNosTbc4WGzELkbr0E1vlnpLePHXiM26J1uR8Y77Xx+X3mvnXTkFAq4dVcx
         TJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=moa0rcMvLHKuxdxI1h9ylYwMNI93SZwQx2b51rTmovE=;
        b=FLa6Zs6CB6tU8IWwlGo/4locgo5AmIdNkx8hfvja1uzGRLaKSBSF4gx9y7mlQATlKY
         NrMj9InSqzc0J77PelV4lABqTnIf0oNXasVambCGdX3eXnLTtQu//2WNWyfmw9WOj7pi
         BrfjILgjAKBq0aUfg0qkcZDOl/le+/+XOQ74oPgqrlrmLwjE1r6mMbpv5wobTWqM7/eH
         70v3iaYKEzxZssgrGWwSrGv9unWoF7e0bTwUb4Zr0sAgPs3ZjUeoBeLOhzeAxVxl1koh
         8PzJTV15CWTCxOQ1AqeXvYty11yUQqBG6hgiJ8c/be5A9hmUfwAHXQWJsRGhdsbcIlsM
         /pHQ==
X-Gm-Message-State: AOAM53212AABjTkGEgVcdYK4ua4JWljAMSh7MdprI3m2IztsAAfDIHKl
        yJHt6WD86uRCGd6o2Qn6CHMzj4E3ftRiILi6
X-Google-Smtp-Source: ABdhPJyG7SJlL33vt+EhoJgcvJFYLIJTjiyxtXvmPN3r7wSO9e/Oxh657Q8n3uaryYzmvEhQ3pgSDw==
X-Received: by 2002:aca:4254:0:b0:322:953b:872 with SMTP id p81-20020aca4254000000b00322953b0872mr1274456oia.32.1651717525118;
        Wed, 04 May 2022 19:25:25 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id n8-20020a0568080a0800b00325cda1ff8csm238296oij.11.2022.05.04.19.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 19:25:24 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] arm64: dts: qcom: pmi8994: Define MPP block
Date:   Wed,  4 May 2022 19:27:05 -0700
Message-Id: <20220505022706.1692554-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505022706.1692554-1-bjorn.andersson@linaro.org>
References: <20220505022706.1692554-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pmi8994 has 4 multi-purpose-pins, add these to the definition.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/pmi8994.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmi8994.dtsi b/arch/arm64/boot/dts/qcom/pmi8994.dtsi
index b1b50c99ada2..0dfdd42f6f55 100644
--- a/arch/arm64/boot/dts/qcom/pmi8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8994.dtsi
@@ -19,6 +19,16 @@ pmi8994_gpios: gpios@c000 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
+
+		pmi8994_mpps: mpps@a000 {
+			compatible = "qcom,pmi8994-mpp";
+			reg = <0xa000>;
+			gpio-controller;
+			gpio-ranges = <&pmi8994_mpps 0 0 4>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
 	};
 
 	pmic@3 {
-- 
2.35.1

