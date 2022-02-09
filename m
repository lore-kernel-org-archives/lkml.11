Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2319BC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 21:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbiBIV7k (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Feb 2022 16:59:40 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234637AbiBIV73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 16:59:29 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B29E01A221;
        Wed,  9 Feb 2022 13:58:37 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id t199so3961815oie.10;
        Wed, 09 Feb 2022 13:58:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pX+Cvnu0fmrHP4h0FLKZGGZgBt+kd9iRuNct+So0cws=;
        b=H+aB/sKcCq/xZ8XjXBU+Ct1LxXuKgCx6kHTVncGyEzTIVJ3ahtxrVXsyGbvLiE48nz
         mzISm8+nqMiIxnByA61W9PWbaQLWwVIs/bYhtSySKQ8Gspbo7XKtMmPeoNB7mVcc8r14
         DrLAgMFcbkRC64oeSboDPTld6rGi7XdJOwyqEfiAkUezRujnv0xioCmuvOff/7HJ+a55
         rGvX5WHbzSkunJusg9Cng8rFDTJVla1HsvZTVuJVi6y+d8MVawTZX7bEoBz8X95fzA4i
         4phVNHQij92c3hTbqW3utA9MkwIUvrWJPdR39a72f/XWw8HcG/CvJofuVkP+9yg9OBFo
         yXuw==
X-Gm-Message-State: AOAM533TAvbd4rpSaRl9LSAFy4puH4eS2BU9+0G7ScjSveRBQPN/FZDe
        PtHkSFrFka5S5oIGzd3zLd4GUs4CYg==
X-Google-Smtp-Source: ABdhPJzKImLMgHDOlCkpD/KisnidgpCVI4UZpl/ZEgH05/OG3wCguOCI6TNX9i5TzwmIRtm/YhWDZQ==
X-Received: by 2002:a05:6808:118c:: with SMTP id j12mr2248200oil.259.1644443916905;
        Wed, 09 Feb 2022 13:58:36 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x31sm2914250oao.13.2022.02.09.13.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 13:58:36 -0800 (PST)
Received: (nullmailer pid 1000434 invoked by uid 1000);
        Wed, 09 Feb 2022 21:58:35 -0000
Date:   Wed, 9 Feb 2022 15:58:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: vendor-prefixes: Add willsemi
Message-ID: <YgQ5CxRLHwnD39Jz@robh.at.kernel.org>
References: <20220202221948.5690-1-samuel@sholland.org>
 <20220202221948.5690-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202221948.5690-2-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Feb 2022 16:19:44 -0600, Samuel Holland wrote:
> Add prefix for Will Semiconductor Co. Ltd. (http://www.willsemi.com/)
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
> (no changes since v1)
> 
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
