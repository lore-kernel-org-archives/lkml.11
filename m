Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B254DC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 04:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347233AbiBIEJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 23:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347194AbiBIDjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:39:20 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58AFC043186;
        Tue,  8 Feb 2022 19:32:54 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id ay7so1207959oib.8;
        Tue, 08 Feb 2022 19:32:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xVw4y7RQcicGcqAuoJIIuX9sgfKI9eeI2fR3E2FgTqw=;
        b=gZs+UuEGlJxmDKsUbx4WSHZ63bRNA+Z/jXjppVaA9Cs0sBWp5rSHKGuWMWfOUr2Jlz
         vcaYWSEn5vCirFeElVKG4Z6n04zq3hNlFl/zcHBYZy3+oAV8XNEePxU8Yfym/mdPxXnV
         +TPlbPJxLzlfLZmYqFbpxZ08QyxhTy78ZOwSEBzdlGMiKqjxqunGvsYptuidZpP7Vvyy
         iiUXOr4xF5J0AsKy4KukYCPhvtc0VU9d2MeIiezCaoCdCy6bmg+ZQzESBlXhNiFw+sVa
         aTPMBsXN/sfEFd/7g+A52TYbCO57QSpfJgUu1+ErQFDvW+Q6UHrPp+x7IFpDq5bXXMVy
         UJ1g==
X-Gm-Message-State: AOAM533e3iDyDsI//Sq1dBH0iZE4a+LZEAc5sUWKH9P34P4/63t+YwrP
        voHO5EeSmAPc/TZ92o+nzg==
X-Google-Smtp-Source: ABdhPJxymnsCCtzX1ASuD0v5iwd+GBNOtOo+3Im/y5HtMBxm3SPRXXSc5a/Bd1zECZyepbo+R32dJQ==
X-Received: by 2002:aca:3657:: with SMTP id d84mr129368oia.212.1644377573999;
        Tue, 08 Feb 2022 19:32:53 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e9sm6251393oom.8.2022.02.08.19.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 19:32:53 -0800 (PST)
Received: (nullmailer pid 3586969 invoked by uid 1000);
        Wed, 09 Feb 2022 03:32:52 -0000
Date:   Tue, 8 Feb 2022 21:32:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Fu Wei <tekkamanninja@gmail.com>, devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v1 3/7] dt-bindings: clock: Add JH7100 audio clock
 definitions
Message-ID: <YgM15GkF7Fv1y3gE@robh.at.kernel.org>
References: <20220126173953.1016706-1-kernel@esmil.dk>
 <20220126173953.1016706-4-kernel@esmil.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126173953.1016706-4-kernel@esmil.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2022 18:39:49 +0100, Emil Renner Berthing wrote:
> Add all clock outputs for the StarFive JH7100 audio clock generator.
> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> ---
>  .../dt-bindings/clock/starfive-jh7100-audio.h | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 include/dt-bindings/clock/starfive-jh7100-audio.h
> 

Acked-by: Rob Herring <robh@kernel.org>
