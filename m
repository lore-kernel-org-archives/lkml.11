Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B951ECAAA1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Aug 2022 17:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiH3R7s (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Aug 2022 13:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbiH3R7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:59:10 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB48426E1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:58:55 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id y10so9058824ljq.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=fFHSYBHtp1mvsz+IAjz2NGyNU51T7wG7r3Us+Us+0Vw=;
        b=Mz+XBr4i91zmayQTLDcg5nbqbzzFaxast2esKZcLiLJmvssU6wnfIVf9n1AD3xLKX8
         Dk60Q2Drb3tsY4ppP2WLs7M7vu9aBP9n+cNA1jHXyPHEOov3PGT/OaBhG/iP07ioX4I1
         rv0Y1LZEh4mjzb2Zb5gZGvSPyK4uL4xLrLPbl+76erVp5Ijdi9TWITsx+o/bZBmiJ1ma
         fYOmjbe6oTev9ddJbGEF/YaJ23El1QksBEv6dItigIKGp8Vvy7NJL+uDgc/RArKRikml
         CIwJUjrfn2jVIXXZMFt4yvD1P5XykKIjuyk9bfu5vIwdY2tuRNOYv2o0Se8A1XC6l7uF
         h1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=fFHSYBHtp1mvsz+IAjz2NGyNU51T7wG7r3Us+Us+0Vw=;
        b=h0t/90ukcP7plS3sRhzUie60pPh4R5rXr/oYrzetqpLvw0apUT13MaJKR3249d2/O4
         5Ee5jJPmYhQdBcYHJlX6cx6+RgadfV4agQOUNS/XPwlFNA1ipY/mPZB96pw3kCtO8vQ1
         3KlVv6JY46NlSBcE84V4sBVrC0YxFSSRC3ENV+esk78OMpuo4DyezNDrdPR6K7O6gBWo
         RDkiJWcY9pYmEA9AbGE8vP2xvRZgaSAnhUletf93t+3J+G34WbzfYtDCU38cOJEZy/LX
         bI+M1tWDxROni7TemYB9+Py/Aca7qwDCckpl7VoYBvvuMfPFzE9DKB0ACPKPXw9e+eEU
         wCeQ==
X-Gm-Message-State: ACgBeo1oiyERRWjG4eoQfwx6/PevKKsTUDFL7ypgvNjCEVAbaVb7DWv6
        tMKWAA9ORLON4PcDXv+3ZQOUig==
X-Google-Smtp-Source: AA6agR45uW8uWrJR4EMgmEiWctiQg92imuC4b8KqOElTDpw7sCyn5YFBnhPT4NSyjt3tUL58uJToVA==
X-Received: by 2002:a2e:a548:0:b0:261:c647:1d86 with SMTP id e8-20020a2ea548000000b00261c6471d86mr7955807ljn.237.1661882334138;
        Tue, 30 Aug 2022 10:58:54 -0700 (PDT)
Received: from krzk-bin.. (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id h5-20020a2ea485000000b0025e6a3556ffsm1851394lji.22.2022.08.30.10.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 10:58:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     devicetree@vger.kernel.org, festevam@gmail.com, peng.fan@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        Sascha Hauer <s.hauer@pengutronix.de>, robh+dt@kernel.org,
        djakov@kernel.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org,
        kernel@pengutronix.de, linux-pm@vger.kernel.org
Subject: Re: (subset) [PATCH 2/2] dt-bindings: memory-controllers: fsl,imx8m-ddrc: drop Leonard Crestez
Date:   Tue, 30 Aug 2022 20:58:50 +0300
Message-Id: <166188232677.14577.9890180783714533041.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220817065946.24303-2-krzysztof.kozlowski@linaro.org>
References: <20220817065946.24303-1-krzysztof.kozlowski@linaro.org> <20220817065946.24303-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Aug 2022 09:59:46 +0300, Krzysztof Kozlowski wrote:
> Emails to Leonard Crestez bounce ("550 5.4.1 Recipient address rejected:
> Access denied:), so change maintainer to Peng Fan from NXP.
> 
> 

Applied, thanks!

[2/2] dt-bindings: memory-controllers: fsl,imx8m-ddrc: drop Leonard Crestez
      https://git.kernel.org/krzk/linux-mem-ctrl/c/c941e6305958fb85e0e4d6c632c8a7a489c76f88

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
