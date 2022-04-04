Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E54C43217
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Apr 2022 23:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241693AbiDDXNe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Apr 2022 19:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343748AbiDDXL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 19:11:56 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1ECAE50;
        Mon,  4 Apr 2022 15:51:57 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id k10so11674381oia.0;
        Mon, 04 Apr 2022 15:51:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8FDTCw1LhxPVakf6kZIMs/Ouipyg5rb6xFyX3nMjsaE=;
        b=F+9zNgTngItX27Oaz6zqvScGcDYLEEPnELN6c6wD4Tsfguiwm919c+JInFCgZJe8En
         7Fh9JPvMtvQrKKfGlnGuFrPw3LzuLlo1pctUaQYmITK0KmEiUgUKHnQRLEGANDHJS0V0
         Lnnc5uDrFTJJM+IU1cLcSLY0iiZONpKQNKojMisr5o/Ku8HABzlGpdt/fkShlQ1rRPRi
         dpCwxqnTC2ehfd4aKumy/holJj82C2mzB54kTjKoPEpqLLSk3tkgZxD/vqiYKfVK/VgO
         NxxaFSJodWBE1sWaJVu0Kli0bjYS51njgQrR9pWPeqxzpesG5gs6h9EHOsHtHaa7EKrM
         JG3g==
X-Gm-Message-State: AOAM531CEhisOtz1SZKdwEHfHoAQhUaqa0qoARa7W3N+gmK0PQZJGizQ
        PRbc/7KYxaPBQwB5yoEnKxd8DlgXSw==
X-Google-Smtp-Source: ABdhPJyBoK3Bfrjahboem3OURDgPWYZVqQRjOn9sbWe0CYCpDin7CjqMpa+zueCnLV5O91bZpB0WQA==
X-Received: by 2002:a05:6808:3ad:b0:2d9:fc59:ef0e with SMTP id n13-20020a05680803ad00b002d9fc59ef0emr241121oie.266.1649112717175;
        Mon, 04 Apr 2022 15:51:57 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s30-20020a056870611e00b000e1976a78e7sm5060993oae.44.2022.04.04.15.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 15:51:56 -0700 (PDT)
Received: (nullmailer pid 2153952 invoked by uid 1000);
        Mon, 04 Apr 2022 22:51:56 -0000
Date:   Mon, 4 Apr 2022 17:51:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 1/2] docs: dt: writing-bindings: describe typical cases
Message-ID: <Ykt2jE8ETuFwKuwI@robh.at.kernel.org>
References: <20220403081849.8051-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220403081849.8051-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Apr 2022 10:18:48 +0200, Krzysztof Kozlowski wrote:
> Add a chapter for caveats or typical mistakes.  Source: Rob Herring's
> (Devicetree bindings maintainer) comments on LKML.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/writing-bindings.rst  | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 

Applied, thanks!
