Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9BAC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 06:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237141AbiFGGjz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 02:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237136AbiFGGjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 02:39:22 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B73CC14E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 23:39:21 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id kq6so20111010ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 23:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hTnxOKZr3+ndForNuYwPMS9kKQWB3G2RjAQYxRP9CpI=;
        b=Vil8nMBL2h+FO48FmtCLBY05Ilnikq4E5A8SWoL+H4u7OcvuJyw9zvJILK1hc1Em1g
         bucYSwUMDG+SR8wbxCFCHKvUPREpF3In+RdWuJ2bUGlfSRerxvm/b9KXnn7an0GSSpoY
         wLTHDWz6W8tkpqdWMG2+bZn3QNORKH8S/OMFf6dzJEmkZkU3RPzRAa0//fxDPtG8ayoA
         BzmHH52W++FAkBmS5rrupzL3nTjvetO2kaUfajVjDS15WHhqnkD7Q6WGPaJWY9AMY90r
         C5bPUkMM1Z3ZWbZQ1ffmNw7Dm8cjOXjbzyyzBIdtFsczXp5ccS/P1JkZP2jNN5V7qw50
         B3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hTnxOKZr3+ndForNuYwPMS9kKQWB3G2RjAQYxRP9CpI=;
        b=hdkZCWOdK1o6ejvgBREpY89blnpfRETEINpUoekoVdordx7/jqGaiOM7wKfplm0J2i
         L73DWY5Rs5U9FFFuH2LxtzA/AG6eyqisodWSTaUx3troy6VWDsblUNDylvC+DR+dTEOx
         Mkq5G39yuvyO+HdawdNk44p+CnSvZlcVOVWmhx0oibAYke+MEiwodeOqKt1TT4sPwfLO
         ZfTI/ChWBVvlXflwzLOXKCrm7M9lqUxfE5B1iYA4v4M5QjTnfg08VKVQkguD+Em2u7IC
         KWdYtBUAcgKp+K7UAwEKqHuedFp5YO4p9NRW7NdCQ2QOi3NLkbV3SWZ1+DDmgLigeyiM
         625Q==
X-Gm-Message-State: AOAM531Mj6Ol5ToA2+QjCZ+m2zIhVrjGztA3LjT6eP/Bm8/Sno3Vpodo
        NBgNCUpa5WDpKw70BAAGF+344g==
X-Google-Smtp-Source: ABdhPJznIa7ycw86Mz/saSlmjmACL+gX5E2xoZyqN9IfBg+jlMZH1KHXpzMpCPQ/+e4Nm4+dFBZ43A==
X-Received: by 2002:a17:906:1e8b:b0:6fe:c45e:814a with SMTP id e11-20020a1709061e8b00b006fec45e814amr25037866ejj.304.1654583959451;
        Mon, 06 Jun 2022 23:39:19 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id jo13-20020a170906f6cd00b006febc86b8besm7016888ejb.117.2022.06.06.23.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 23:39:19 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     Chanho Park <chanho61.park@samsung.com>
Subject: Re: (subset) [PATCH v3 4/8] ARM: dts: exynos: use local header for pinctrl register values
Date:   Tue,  7 Jun 2022 08:39:12 +0200
Message-Id: <165458395109.7886.16177873811849349064.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220605160508.134075-5-krzysztof.kozlowski@linaro.org>
References: <20220605160508.134075-1-krzysztof.kozlowski@linaro.org> <20220605160508.134075-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Jun 2022 18:05:04 +0200, Krzysztof Kozlowski wrote:
> The DTS uses hardware register values directly in pin controller pin
> configuration.  These are not some IDs or other abstraction layer but
> raw numbers used in the registers.
> 
> These numbers were previously put in the bindings header to avoid code
> duplication and to provide some context meaning (name), but they do not
> fit the purpose of bindings.
> 
> [...]

Applied, thanks!

[4/8] ARM: dts: exynos: use local header for pinctrl register values
      https://git.kernel.org/krzk/linux/c/fd1d3737f605c8b821794b031e3ed0920f6d843d

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
