Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99231C433FE
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 23:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573222AbiDEW7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 18:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1455692AbiDEQA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:00:27 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11D0282
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 08:19:13 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id h7so23866089lfl.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 08:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QNjrm+2U8Wp4qQE1rogdNw3rgJSNlOSLgoVBhegCMNs=;
        b=Tqg2yrve07ADWEUbyvd1akmjxeOXld1+zmU3UV3F3XWGv5FUnPXiX9N+VO83Y4JEEd
         MSnqMkjllKlq54jdxCTUsddUW2WhAIPVq2rFPlAyVzZ9GkIu7mkknpkuBo+/cHUY6jao
         yr+/g5L22aSYGDbB4+wgFmKITWcu4VMLxwxjh5UbsBPt18CUlT6vaVOcJnK+AIFRDyN7
         N9s9INLJ3OqDc4X7w3IMv+64eJsxE40BX4ZZh19IPIZJ4IkMDQ68DshnBf0pQXRjLlm+
         986z+zcSdLK9PaBQoLTctUm7b/JffBHCpHC0VaT9Vbl/pzZWS1j9W+eGZLjsQnd4Lk7D
         KSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QNjrm+2U8Wp4qQE1rogdNw3rgJSNlOSLgoVBhegCMNs=;
        b=VKiY9aw6H3CtrDd3FtqC+T/m5VLFslgV1hE6kUvdfF3ebNAJalA9VNS2KZq0u6pCQy
         eooK9lJTMe9xVENQp1QUw0cp7I//UTRadp66Lq1mrfH6/YbqEKBdiw0hgADSAteZBPk+
         Vf6Y26z4/qrSilPRbRpEw/WuxYooWh7HGND4w//m96jay2aVPduzImTQ9dh9+qVxYS5s
         0V4x+9YIEVJJjSNxm6xuvsM3kXhwHCYWZquugAHM1xIAJsGy7hLBw8lrgkCxAQ3niw6U
         ajPnSe6FVD0xuhIFmE8l05SslYF/1aQkS+kav5i4bPUxuLqSllYK20t0LrDTDg+WC5Hx
         naoA==
X-Gm-Message-State: AOAM533Tj6/811oRp/T487JK723fO1aOmwsAEApyEfCYg29G9Genq0os
        1vbY/L5v75pVu7f+nE1zIIyyzUCoolj+txEkc9Q=
X-Google-Smtp-Source: ABdhPJxJhOBNDoxuGxa3tHh6Dv34VZijI3nZI9DmqyOTZ9P9dzaQTLrSUZ6XpCmXw9eQQC3cNsaYahVZvvY1gdoam48=
X-Received: by 2002:a05:6512:2627:b0:44a:2987:218b with SMTP id
 bt39-20020a056512262700b0044a2987218bmr3077182lfb.563.1649171952064; Tue, 05
 Apr 2022 08:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220405150912.GA625670@euclid> <YkxdasBGZ3m2Yu66@kroah.com>
In-Reply-To: <YkxdasBGZ3m2Yu66@kroah.com>
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Date:   Tue, 5 Apr 2022 11:19:00 -0400
Message-ID: <CAMWRUK7c-hqiz+KEFkqBuvu1syCwSnF4UZzbkPFw-VWABm9qOw@mail.gmail.com>
Subject: Re: [PATCH v2] staging: rtl8723bs: fix indentation
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy linux kernel <outreachy@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 5, 2022 at 11:17 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Apr 05, 2022 at 11:09:12AM -0400, Sevinj Aghayeva wrote:
> > Adhere to Linux kernel coding style.
> >
> > Reported by checkpatch:
> >
> > WARNING: suspect code indent for conditional statements
>
> You are also removing unneeded comments, right?  Please explain that as
> the documentation link the bot pointed you to showed.

I specified that under the --- line:

v1 -> v2: Remove the comments that became irrelevant with proper indentation.

>
> thanks,
>
> greg k-h



-- 

Sevinj.Aghayeva
