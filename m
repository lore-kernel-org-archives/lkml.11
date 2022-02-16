Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651E3C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Feb 2022 19:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237949AbiBPTA2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Feb 2022 14:00:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237950AbiBPTAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:00:25 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838C12B100E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:00:12 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id u10so3538377vsu.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S5BSR6cJxy3OIvfsMR+O/vOvcelF9SA+qkn/HKZco3Y=;
        b=pJZEPf7Kl86YFfMRtKeB4nfuiB3C1EHAHkDlTTaudqjfpSYETB8NiUGs1gpdRJ2BoN
         JDJTGcw8UHBQZxjG+6PAiA1EBsXT63a55qxlKJWNxUpS9qEoBtmC0ttxpCk1ALzpYlww
         1LqxJi8+uVmwy7hChpHr8VsoaqPUwnZajxLgoyrTgP0R6/l46hRBpvKCtD9/DUjHROCp
         4RNnONCunQGzd8kziLrLCoETzTfqzlDrRDEhr5IvI5OxMGb0zrRHSCS32Hf95GkAYXD+
         lIWAkfdrPQ5R3+s5EoOUMANqAljP1BNwsIYbt2hM4sz40rj0xj5+LiguFL7KEYW2dQvx
         SEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S5BSR6cJxy3OIvfsMR+O/vOvcelF9SA+qkn/HKZco3Y=;
        b=b0VQDLMnkpqveDvSeglTFmfvIligbv9Iv2840+RwLQ0pIiHfoST141REjOg0ebR2+d
         E72Dq4I4uexVcOBwRhk5h10PMUTJpE29jlgi0jSPNGoMJJiZyGfO3UeJPHvXWLiySPqA
         q+tI3T0pneEwt2h4i/CZvpgqZAUGn9tfeNCpaiJg5hU60AjFjUKsk+3D16Xs68G031zF
         XQ9ev6mI3XKEtWjiUmmRLHVpxC7IcrNMrJn/Ps+oGOJ/MQKbGRxbDsAfKF6ogUqwri3q
         yo1OFxtUN8QgBs5W9xPIMob4q+jkrvySrFmCYQt4Cw/0fubEXpjLuXz3zEIqDCCOHsQX
         pjQg==
X-Gm-Message-State: AOAM531Qczr/wi3d3mCYXLCS/NCd0tVvK+3FVD2xCIAnYOPUsvFiwrgI
        La2OYuJmyJ5N5+0q5x4R7xEIo65+OJyMRgqTB8QtGw==
X-Google-Smtp-Source: ABdhPJwk7yxK99Lm08CHdUF76ZrAthD1mX/3wkVG+nZM+tQ93MpiegxE69ayG2fXpIM8XyQLobOKlFLiSqpNIXgbiPU=
X-Received: by 2002:a05:6102:374e:b0:31b:956a:b0da with SMTP id
 u14-20020a056102374e00b0031b956ab0damr1948636vst.35.1645038011504; Wed, 16
 Feb 2022 11:00:11 -0800 (PST)
MIME-Version: 1.0
References: <CAPcxDJ7nriZEJHF6dMPR7tQ+dGuueyRjw1NC+4CbjxiAT_S+ZA@mail.gmail.com>
 <20220208150945.266978-1-juew@google.com> <Ygwka++3eipjQzB2@zn.tnic>
 <YgwnqTc8FGG3orcE@agluck-desk3.sc.intel.com> <YgzRsfWOmqkNiNI7@zn.tnic>
 <CAPcxDJ4=iknzYbN=b2oQxvJyODkQ_MWEj1wkKEuGwf4HQ3aPZA@mail.gmail.com>
 <Yg08Uhg0fZ9xZuP2@zn.tnic> <9f402331d25c47b69349c8171bbd49c1@intel.com>
 <Yg1ICgHfMYxwHyig@zn.tnic> <7931e48318d64e808a2ccb30ab6f7995@intel.com>
In-Reply-To: <7931e48318d64e808a2ccb30ab6f7995@intel.com>
From:   Jue Wang <juew@google.com>
Date:   Wed, 16 Feb 2022 10:59:59 -0800
Message-ID: <CAPcxDJ5t47M-+Bn_D+Vj7zbJTxhjrx=HsLX=iQj-EF_h2oVTsg@mail.gmail.com>
Subject: Re: [PATCH] x86/mce: Add workaround for SKX/CLX/CPX spurious machine checks
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 10:58 AM Luck, Tony <tony.luck@intel.com> wrote:
>
> > You should've lead with that - this is basically one of those "under a
> > complex set of conditions" things.
> >
> > Anything against me adding them to the commit message?
>
> Add the three conditions. Not the "Google has billions and billions" joke.

Thanks for adding this important context.
>
> -Tony
