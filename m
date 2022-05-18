Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8793C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 18 May 2022 23:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiERXB6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 May 2022 19:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiERXBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 19:01:54 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960CF939F4;
        Wed, 18 May 2022 16:01:52 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id er5so4836230edb.12;
        Wed, 18 May 2022 16:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6ioRF++yogDTNZJ4Kl3hvJYBh4fkIppK/Wa57zbKnxE=;
        b=dZLYTjgfXvGKrcOJgLdfrcVQmXdbl01y9E2zS2V173AVk0nf87RVXghCqbt/Xf0U3/
         vs6pOnG88lU9fIFy8G6c3EEngJRmatjEmdB4p7wAybYQAhqZLV8gVmm7C5wWHj+DdbnZ
         NMvuNYbe+pBaddVyIEc24Zg44oNutQMtXcUOcW7ykeZaKu0XD0tdehGPnYWWcLs6PCys
         WEOBzd5BL6YkfXOYTpaHPgrhmpMYntvAu39qWo9njGmHzNhLSQDXgY3eLF1rb+/NVqR6
         4M776LXs0ZDSWkPF+cTalP1idtJNOuApECnawb+wu5esJH9Hdmo6uMXdhLEVAAWiEjsm
         KFhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6ioRF++yogDTNZJ4Kl3hvJYBh4fkIppK/Wa57zbKnxE=;
        b=JUUnv9Kek7JRPZ81WEzIWYMGPEdKk7lIfeozJEUQ9/Vts/8AzpBVXDaCiLHTkuT5/C
         YTbX88S0bsVrk+vhx8tnbNFXuUHXJf+CCJC1MAaFL1JuZcNAo+RzRAreIDjkQg1rAgop
         hwGy+Mdfh8ww8cf9BzFSi+Cf6hublDDwP8p+1UoCTixNBFzK1GbPFfuqJM9gpwGNvFIz
         IhBRIpUY/ykIbEMmsRFNvLB6EhsfwEusxbDon8AeWMXa29NH5t/Gjub+2kQ5B1x7muD1
         OwxpECYBRlBZPu07lJi6j4YO7G8u/wT6QepdxvYV5JeN9uZPOqnmq13hKLazupgRXyoS
         farQ==
X-Gm-Message-State: AOAM531I/Ux4xuNzkCkEIx6YZh3+vwxpyh/2UWIpl+oI3jaWo0x8xGe0
        shrm1liiTIxG4HjKfO2GMGY=
X-Google-Smtp-Source: ABdhPJxHfBudDsDKkD0pf8fegVDmKf0xMeiiqzGZrY8gNJ3s++1QVHB8ti+ABqmq90TYEULVO6oLPA==
X-Received: by 2002:a05:6402:1248:b0:42a:cc7d:2c22 with SMTP id l8-20020a056402124800b0042acc7d2c22mr2253203edw.284.1652914911103;
        Wed, 18 May 2022 16:01:51 -0700 (PDT)
Received: from localhost (92.40.203.120.threembb.co.uk. [92.40.203.120])
        by smtp.gmail.com with ESMTPSA id f13-20020a170906738d00b006f3ef214e0dsm1467626ejl.115.2022.05.18.16.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 16:01:50 -0700 (PDT)
Date:   Thu, 19 May 2022 00:02:48 +0100
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     dan.carpenter@oracle.com, devicetree@vger.kernel.org,
        krzk+dt@kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        mturquette@baylibre.com, paul@crapouillou.net, robh+dt@kernel.org,
        tsbogend@alpha.franken.de
Subject: Re: [PATCH v5 2/2] clk: ingenic-tcu: Fix missing TCU clock for X1000
 SoCs
Message-ID: <YoV7GKiaosmX6QnQ@localhost>
References: <20220412122750.279058-1-aidanmacdonald.0x0@gmail.com>
 <20220412122750.279058-3-aidanmacdonald.0x0@gmail.com>
 <20220518204734.89090C34113@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518204734.89090C34113@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 01:47:32PM -0700, Stephen Boyd wrote:
> Quoting Aidan MacDonald (2022-04-12 05:27:50)
> > The TCU clock gate on X1000 wasn't requested by the driver and could
> > be gated automatically later on in boot, which prevents timers from
> > running and breaks PWM.
> > 
> > Add a workaround to support old device trees that don't specify the
> > "tcu" clock gate. In this case the kernel will print a warning and
> > attempt to continue without the clock, which is wrong, but it could
> > work if "clk_ignore_unused" is in the kernel arguments.
> > 
> > Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> > ---
> 
> Can I take just this one patch through clk tree without the dts part?
> dts snippets go through soc trees.

Yeah. The patches can go through in any order but they both need to be
merged to fix the bug -- each on its own should not change any behavior.

Regards,
Aidan
