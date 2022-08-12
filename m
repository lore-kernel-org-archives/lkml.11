Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46518C25B0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Aug 2022 16:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239152AbiHLQ4K (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Aug 2022 12:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238551AbiHLQ4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 12:56:06 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4652C37FAD;
        Fri, 12 Aug 2022 09:56:05 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id i84so1255758ioa.6;
        Fri, 12 Aug 2022 09:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=lA3f3otAT+iFQtPwg3K/WfF7yz98PPxitrFwV9W2g10=;
        b=m14Tso7rFtjsOjjDaIOL3sKQphBYMiZjLjROXu6CJQZGpG28ncFAg1kUW4m8CHTipa
         SzCVlxbWSCnj13McDxPG81pKQtLUXNxXqkPfLrauQ8UaEsYabU2hHCio7sBg4q90jX02
         zvji2oOtwmXfLYfHF5o0esHfjkC8MuTI7SiydEcTAgSN+CzcHB8pRuUBZyvrhQqlX143
         YHX5ihJwdmLDX5AihljqRzyPGFJAM9TWmTIXQH2cuC7VlG543zL+mFOTmtLf6vIcdBKP
         1b4tlWB5VHjpFNO2N0NoTRgciwHo8KbZ5DlAKzzHdhr7Ev6gB02ANhdbTApVgYEDgE56
         CXEw==
X-Gm-Message-State: ACgBeo00WsfLCsUtlzXHPMF+i3h23KDnthX+wcvIcz10M6TGcnHW960/
        jfuNmFlTeTQxDsh3FXDppQ==
X-Google-Smtp-Source: AA6agR53ym77b2F1XAcoznh/2AR8P2rUYI8OEORisaCv7oueGq+oRS+W6sU+MQqeAu6IWP9MJSYfpw==
X-Received: by 2002:a05:6602:2d0d:b0:684:9906:9fd with SMTP id c13-20020a0566022d0d00b00684990609fdmr1918800iow.86.1660323364503;
        Fri, 12 Aug 2022 09:56:04 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id z16-20020a05663822b000b003427170b558sm87140jas.57.2022.08.12.09.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 09:56:03 -0700 (PDT)
Received: (nullmailer pid 317289 invoked by uid 1000);
        Fri, 12 Aug 2022 16:56:02 -0000
Date:   Fri, 12 Aug 2022 10:56:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        chrome-platform@lists.linux.dev, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Prashant Malani <pmalani@chromium.org>
Subject: Re: [PATCH v2] dt-bindings: chrome: google,cros-ec-typec: restrict
 allowed properties
Message-ID: <20220812165602.GA317229-robh@kernel.org>
References: <20220811062245.4316-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811062245.4316-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Aug 2022 09:22:45 +0300, Krzysztof Kozlowski wrote:
> Describe exactly what properties are allowed in Google Chrome OS EC Type
> C port, so the schema can properly validate the DTS.  Existing DTS
> defines always connectors with unit addresses, not a sole "connector"
> child.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Prashant Malani <pmalani@chromium.org>
> 
> ---
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Changes since v1:
> 1. Correct subject prefix
> ---
>  .../bindings/chrome/google,cros-ec-typec.yaml     | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 

Applied, thanks!
