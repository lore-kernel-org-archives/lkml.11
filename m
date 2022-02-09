Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7948C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 20:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbiBIU6l (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Feb 2022 15:58:41 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbiBIU6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:58:34 -0500
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BABC03C1B8;
        Wed,  9 Feb 2022 12:58:37 -0800 (PST)
Received: by mail-oo1-f47.google.com with SMTP id o128-20020a4a4486000000b003181707ed40so3889152ooa.11;
        Wed, 09 Feb 2022 12:58:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zPbMVchSBzMb3DRU50KOh4bvFIb2tylymt9Rn0zR0Yw=;
        b=orkFz/DdQOukh6iBxfQVV37eQSIH/gTkVKIZ+DuuTPHXoXcjbGzRTPA5RajZAcF6/z
         GeYz9iKDFUm4cUcwFimYGb3inILdmuQO3X+mD+FZuWjLPW7ilwBQyBrdV5Pim6aGvKzQ
         nmWv54JGwW7didE/poZaOkgCQSDwI2r/ywzluF8VL0+Cv+erMrJtcBDPjtyr5cjoPwXq
         Z6JC9lhVggejhzFJILVfCI84rnrJhTtApzbsM+z4QNExGEAjcOqGHHdm2LZhaqrULM/2
         y5+r7t61k3QmJ2fX9vo8EaKz3n3jWvtO05/FGbGWP9Rzsbg/fwdOyqYebcpSJ9670ua8
         kBDA==
X-Gm-Message-State: AOAM533WTCw92AORvTjvy5EX1Z5GYSIHP6RB34pR+r5gYRvauoGSlbk4
        RttfgLynpFPjir+4Nli2ew==
X-Google-Smtp-Source: ABdhPJySP7RiAIkhAP/NMcvNB/khUFigoTNlZRS5IuvUSWT+5WXsS6bvdAC+if5jHaAddbDHc8XLPA==
X-Received: by 2002:a05:6870:d384:: with SMTP id k4mr1551501oag.276.1644440316444;
        Wed, 09 Feb 2022 12:58:36 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 23sm5053278oan.6.2022.02.09.12.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 12:58:35 -0800 (PST)
Received: (nullmailer pid 897934 invoked by uid 1000);
        Wed, 09 Feb 2022 20:58:34 -0000
Date:   Wed, 9 Feb 2022 14:58:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Jonathan Bakker <xc-racer2@live.ca>, devicetree@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v2 2/6] ASoC: dt-bindings: samsung,arndale: convert to
 dtschema
Message-ID: <YgQq+gmRk4SRznSY@robh.at.kernel.org>
References: <20220129122357.45545-1-krzysztof.kozlowski@canonical.com>
 <20220129122430.45694-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129122430.45694-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jan 2022 13:24:26 +0100, Krzysztof Kozlowski wrote:
> Convert the audio complex on Arndale boards with Samsung Exynos SoC to
> DT schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../devicetree/bindings/sound/arndale.txt     | 25 -----------
>  .../bindings/sound/samsung,arndale.yaml       | 44 +++++++++++++++++++
>  2 files changed, 44 insertions(+), 25 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/arndale.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/samsung,arndale.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
