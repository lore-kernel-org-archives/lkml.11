Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCEAC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 10:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbiCVKwf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 06:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiCVKwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:52:33 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B52814AD
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:51:05 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n35so8732138wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fW7h21v3Ivjw1G7/perEqnpmWeToQrSlBMPA8HUbBbg=;
        b=YlFDV8YLOUfJUtA/tnmM25PrK7KOpQHQY2lGFJMNk+l+60xoMCycTAuuHx3S9rIHY7
         nMwNl0FokoOoLTGslZoRXBrjdkltAkXoRTeoOagHgnu0ekn2QfjMOMPRSayMUNea2EHD
         PmbxEJz151Z3iqzvcOP+m6CfWfPU2GVHs6/nvtZQw1zlhgKRTSQf0FwmL5SEK4230H5M
         FjzrbBFkViZarSr6H04LfdhpuLzB7XeLqa97LQoe8iVIuk8hH4bFnfZh6ZPs183AtsoC
         mBE6YFlJ5Yai3Xtb6WuuGKZymUnl/uFszmdEWzYyGwJg/0qGITDBcqQ2sieCAFQZcHyV
         GFrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fW7h21v3Ivjw1G7/perEqnpmWeToQrSlBMPA8HUbBbg=;
        b=4VwAYwOLjBrCrHnUK7d3+1Fs3byNzB0TiDIYbv7xljrLEcV7/cgg8qCnDjLpqK2HGv
         UwvzwSNvBwCqkL5+b+z0XW2KGmZ4+qBxcHhLcFFahR9ES0Jsp8iwT1Wux7v2E09mSi5r
         VCl9pdpgrM5ESGpEk08kbxhfl9t2n34qR8x3Sz0rnRCXg5zh7UQD6PlNj4hLNgvBNxWD
         bfudSzQk0pyvWM6mKK3uZVvShM9CxX9X1cmNbGZiHUONP6SL+lGWkN+grtpjoyn3VpbA
         CFQyHLUZ09q70ubw3yStsIjxhHEr+Z5MftBPhTImaPYH4Kxktf21SijJ2l/oaXGDAcuk
         KaFQ==
X-Gm-Message-State: AOAM5327JB93OKzqZEVU9jy1S0YobWGV8faulJmNeIefhSjSgdjjSZUC
        AY0YNdaNO9erT60Fpf2S8A2B6/DdxPw=
X-Google-Smtp-Source: ABdhPJxFEtSvxdd+B1CGdwG6gjVZbwxFsjrRBm3mgCGTlktWdC2/h9/QjppSlG72zku9Vpj1ck7x5Q==
X-Received: by 2002:a5d:5886:0:b0:204:85e:5a3a with SMTP id n6-20020a5d5886000000b00204085e5a3amr9875996wrf.434.1647946264431;
        Tue, 22 Mar 2022 03:51:04 -0700 (PDT)
Received: from leap.localnet (host-79-37-100-169.retail.telecomitalia.it. [79.37.100.169])
        by smtp.gmail.com with ESMTPSA id m9-20020a05600c4f4900b00389e8184edcsm1617116wmq.35.2022.03.22.03.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 03:51:03 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Sathish Kumar <skumark1902@gmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8712: Fix CamelCase warnings
Date:   Tue, 22 Mar 2022 11:51:01 +0100
Message-ID: <2364205.jE0xQCEvom@leap>
In-Reply-To: <1786742.atdPhlSkOF@leap>
References: <20220318101440.13887-1-skumark1902@gmail.com> <3a85ae64-00c1-6483-f1d7-c12abdd3ff3a@gmail.com> <1786742.atdPhlSkOF@leap>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On marted=C3=AC 22 marzo 2022 11:42:21 CET Fabio M. De Francesco wrote:

> The reason why this pattern does not work as expected is too long to be
> explained here. However, I think that Greg is suggesting to you to resear=
ch
> and use what are called "Condition variables".

Sorry, "Condition" -> "Completion".

=46abio


