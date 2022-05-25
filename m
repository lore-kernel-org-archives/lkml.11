Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD787C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 May 2022 16:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241233AbiEYQxc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 May 2022 12:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241686AbiEYQxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 12:53:30 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74638A32E
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 09:53:29 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id j15so1384508ilo.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 09:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fMVWcc2Fcs7483YteKBUPyqdYcRTbwWYB0BIwDE1we8=;
        b=YOx2w5RWZAC5rYU2PF/0+u132PRXsDu/pAC5xU1ww08kUpv2U6Vc7fBfsXsujV78D+
         F5h0qSqa/CsgcWdayPNiq0tARPvWh1RUI0HbwWNdrVGKrmu+cQ50avwY46d9XHj0k92f
         tcZg8KTdmwjOpljIFzPdVxxUaOZiQe1c6GWoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fMVWcc2Fcs7483YteKBUPyqdYcRTbwWYB0BIwDE1we8=;
        b=AF7Y7lJlFpPi2hNHWuNQnqs5lZFp6DwxyPmxRh8Mc9xFU9Zgb/edYWCMR1XCXHFPh2
         5Z6cgD7RtdvJ8DFTXzWZbJwHoN9woVdltDkeqbipFKLDj7cmBuWG2D94low9p+O1G1KH
         92S4PYcx52osUMBLTADaP460E6uofUuNkjJXljwGTKKUYxyXUdBQ+PPQMS86j2z+OODF
         OtqVlvyOJVgqhlDKgyW3W8tHUMNPAeObMPAamgPWQJ6xLqt3/mPjo/ScfODk+8KEY7Lx
         OHMpATM/joGqfvNVQwZqoH75wkcmHJi9j+AHSg//SJVyPLzO2012mQC3TCqLhULBSzEU
         1AyQ==
X-Gm-Message-State: AOAM530pibHrs+z/7dFAaBBZmKoGE91i3ofopwKx3hMwdT7g6kDH5hq6
        C32UlZK0QzxA37fihYUFxZ6e1fljFixj5L8dIAbxow==
X-Google-Smtp-Source: ABdhPJzjWXZpGnlzxJBkLwmaUwyMbRcY9htKb0Lr01D9ZnZkV3/ycaF8VgIJvY6bFX7vQLmhQpYAdsIEQKl/R5j3RqI=
X-Received: by 2002:a05:6e02:1d1e:b0:2d1:6ef0:1777 with SMTP id
 i30-20020a056e021d1e00b002d16ef01777mr15531918ila.35.1653497608847; Wed, 25
 May 2022 09:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <Yo4qTnYYT+55vlQ9@gofer.mess.org>
In-Reply-To: <Yo4qTnYYT+55vlQ9@gofer.mess.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 25 May 2022 09:53:18 -0700
Message-ID: <CAADWXX-rcvHAXEn1PVScSmDf9kZRVf=Z2R3nyEuNdsqL+z3pEw@mail.gmail.com>
Subject: Re: [PATCH] media: lirc: revert removal of unused feature flags
To:     Sean Young <sean@mess.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 6:08 AM Sean Young <sean@mess.org> wrote:
>
> commit b2a90f4fcb14 ("media: lirc: remove unused lirc features") removed
> feature flags which were never implemented, but they are still used by
> the lirc daemon went built from source.
>
> Reinstate these symbols in order not to break the lirc build.

Applied directly to my tree. Thanks,

                  Linus
