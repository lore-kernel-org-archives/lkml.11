Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89DFC433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 13:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235875AbiCVNsF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 09:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236046AbiCVNsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:48:00 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DF026ACB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 06:46:32 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2e5827a76f4so191014777b3.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 06:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iQXVtoNNOTzoC5qZU7/1ecuc9O/zDp2OQHUTN6wFNH4=;
        b=qXbsV6VDEGOklazgM3cMrjtcJViQEQD+5sjq/f8HPRSOkw9PfJbLmANL2XxUdpi8nU
         kg6sSs8d6uPoAfawQLGXG2TWj7dBOySsSfG8Fb6RH03xwEx8SaWEWfS35xIQbuHBL7jE
         aaeKfKFPuOfsoaulDr6cv6o3aIeJ/udNHdKCSKlieJ0kzF6RJDNPd81RZ+y/3BqFmfx8
         qgGJaZSdQqwop60RX1HT58wL91s7krigV8jwHibUgizeSB3IE9DmeTeG4/nP3pBXxRKJ
         q/BKLJ2G6rBiS/5tdRicXh/eY/ZltWUa4hwkcC5/5430zPwc1CZ/coRxWKFjzAGz+AxD
         SABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iQXVtoNNOTzoC5qZU7/1ecuc9O/zDp2OQHUTN6wFNH4=;
        b=Wl7q1AGJLKhHHL/39DyOPuGG4qsTEtkp5XBfbh1yxhB+QdTMYE1/y9ZDffkle/1VuZ
         Z+R2hAoYM8aIk1ROFS/ecV2bdiZ0pTsdcoBm8d8rttF/LduWtv5+n/T48tp/k2CwqKbn
         u0lGrjG3ob17T3A4FsaKG+9k9RTAKQTKg3jFzrJMQ1pQtLYxmI17ntdjQh9HQOoXiTKq
         d8XphzpEHOZLyfYVEvZ6ft1BJHnnZmGE5mu4/As4jFtfPXhvz2iILa0AfQBQf+qiGHAS
         4Mu1V0XH4+hBPjQB0NfPM355KrjXdFiirxTLtYI4PqjKAZqhVURBa0v1xzxjWnoS5aUg
         kxow==
X-Gm-Message-State: AOAM533rE0lAZlJ7Qo35JE0MmzU7CDizTFdR3P5HPzatOSQ/2feCc6z8
        yNeXai2loThbp2ZeHtBAp359d9Rks63AiaRk13fKYiXvTBF2dQ==
X-Google-Smtp-Source: ABdhPJzFT8gy0YTryuzIkqAwXuMAOd4TJntnOiSZt+GqRpVTvpk3Jc9rNKAQjUkIPCmI5srs5BWm4mxrQHc9KwFPhb4=
X-Received: by 2002:a81:5dd6:0:b0:2d6:3041:12e0 with SMTP id
 r205-20020a815dd6000000b002d6304112e0mr30293148ywb.331.1647956792172; Tue, 22
 Mar 2022 06:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220322121338.27428-1-liqiong@nfschina.com>
In-Reply-To: <20220322121338.27428-1-liqiong@nfschina.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 22 Mar 2022 21:44:36 +0800
Message-ID: <CAMZfGtVxFieFwEB5Xw0yKbri39og97u2RngRABTAUVXZSD_2Vw@mail.gmail.com>
Subject: Re: [External] [PATCH] mm: remove unnecessary (void*) conversions.
To:     liqiong <liqiong@nfschina.com>
Cc:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, yuzhe@nfschina.com,
        renyu@nfschina.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 8:14 PM liqiong <liqiong@nfschina.com> wrote:
>
> No need cast (void*) to (struct hwp_walk*).
>
> Signed-off-by: liqiong <liqiong@nfschina.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
