Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29010C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 16:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242995AbiBYQaY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 11:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbiBYQaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:30:21 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB00918F231;
        Fri, 25 Feb 2022 08:29:49 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id l25so7932790oic.13;
        Fri, 25 Feb 2022 08:29:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=naSsM7I8wSLsPxrWNpkiTZvYgpihXOeO606QXithJEc=;
        b=07QBKh01lEO2WQzfku6WlqnkdOt+jbdqzcg5DYlkn0K0YlDq6Qpx2bmobwSPapl7b8
         ga+h/ySAgJHLR6Fss+TkwaijgxU4RJcoJDE4fssq6j8OoEHsj+g7luM4z5+/yhC/X3C9
         tPLFCJHtBD6quNEBC2YR1kz/ohe1Kq/Aa8ghMfNydo3pBr4pnwcLO2IvimQI6z/E5Vjy
         GRMXSWG6+ZmBjPxsgfWzcjK56jLotYydaXDikCqa4m3oMDvnIBMp/HHs/6MaAAdl6hRG
         vath9MNc8pvaoPFQ6nqqwn5V4CU7CBk7PB9eni7YzuIR9/P7FtZYcvo9PGMkBCjgd9W9
         WQKw==
X-Gm-Message-State: AOAM532WOL2MQ/+luZjgnskVqiOZSTk0SQmArUkaDMivNcpEs+ibidVB
        BUM8QaBl8BkFG01kTfbWUw==
X-Google-Smtp-Source: ABdhPJxTu/Q0i6gFyvjtJDQNTthYKNwRqUf2Njh5VAeQ24wbgPlw+DY2KFsoDBspdGF+PzetmwCd1Q==
X-Received: by 2002:a05:6808:30a7:b0:2d7:6418:8d5d with SMTP id bl39-20020a05680830a700b002d764188d5dmr76758oib.155.1645806589137;
        Fri, 25 Feb 2022 08:29:49 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id z9-20020a9d71c9000000b005ad12cbc899sm1316008otj.36.2022.02.25.08.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 08:29:48 -0800 (PST)
Received: (nullmailer pid 1044481 invoked by uid 1000);
        Fri, 25 Feb 2022 16:29:46 -0000
Date:   Fri, 25 Feb 2022 10:29:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        netdev@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: bluetooth: broadcom: add BCM43430A0
Message-ID: <YhkD+qoEfHuo8nqD@robh.at.kernel.org>
References: <20220216212433.1373903-1-luca@z3ntu.xyz>
 <20220216212433.1373903-2-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216212433.1373903-2-luca@z3ntu.xyz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2022 22:24:28 +0100, Luca Weiss wrote:
> Document the compatible string for BCM43430A0 bluetooth.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  Documentation/devicetree/bindings/net/broadcom-bluetooth.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
