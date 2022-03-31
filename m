Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19177C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Mar 2022 08:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbiCaIkq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Mar 2022 04:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233057AbiCaIkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:40:37 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9684D43483
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:38:48 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id qa43so46514902ejc.12
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9RMKKrryOVnu3VhzCD1VF7LZZR0DSgayzdUmb3Tu53k=;
        b=c/a8HkvGusD0VHfseWle6cB/KMsnNLxZtaI9E6YEPd2f3Ay7SSaywbcuyl/qOuXpx7
         5/fkW2lXkltLFr3B0LVE0/SHh0jLHqaTBs5PWnEUBNmVxT18zw3pQfsa/HaoTRIAnmjs
         qPXoZCjSC7i04J1uDtkAmhsb4Vm0QdvIWMBQwPb2oJ6tzNUFdMucD/PFbUK7BFLZoGtq
         Xg7bHb/csIsmHtf35TzKjMp4iA6QDF+67WWet3t1AoXZsR4hzkkXATvSaSuFQWkmo9u/
         4QWXiMij+6bFeI32M7XMl93xmxqD+YufjQyzP79v6BNBoSAl+LidnUb/1nGSyma1IsOl
         VEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9RMKKrryOVnu3VhzCD1VF7LZZR0DSgayzdUmb3Tu53k=;
        b=b8Wq9A7TpDpCQrNyH99ysZbfkq1CqgFimpu75e0K+3fEQue4Fj+Fm7obOnzif8p4xp
         QRknDIu1TeK72GFfyKmE6Q47e9PG04Aiogb2hPszSOAXUhUoRhMY0A7g53xAsOSOIXU2
         dh/y+gXUHC0fUvn0Vwqm6Dl4qeOuDY2m/8DLIaMgGEyxVwPLLRh1ErOcOJa8ijAqM//L
         Ir9WVAUa6CXejl1VKfaTJ7hvEtJTWn0mwh33kHOBlNw0j7wOu8M3JaNiLHJXQpRrbC9l
         2dDSjV+NqRHLtkGIsaMZOK1Bnp32d+JMj1sr898ZN24cs2jpLZrF+Ro6U+XHeKaftXhR
         6Erg==
X-Gm-Message-State: AOAM5335yAB3n8iZUfgbr92x02e9r7fYZjBgdijzzigTDZlyJxAhgO+T
        V49GP7ozvUeJfZT2Dy+Jn4ffTWfXvmTHKYl5PlNsww==
X-Google-Smtp-Source: ABdhPJzZ64lT4jQoxd8nCjGxDTqo/uciOJixCc510kAeSEPLXlv1Gbkim7xxeGQIiJdrsnhjG56ttTAdPtyKxTCUc5o=
X-Received: by 2002:a17:906:5d06:b0:6df:b0ac:59c2 with SMTP id
 g6-20020a1709065d0600b006dfb0ac59c2mr4142364ejt.758.1648715926986; Thu, 31
 Mar 2022 01:38:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220330211913.2068108-1-wonchung@google.com> <s5hzgl6eg48.wl-tiwai@suse.de>
In-Reply-To: <s5hzgl6eg48.wl-tiwai@suse.de>
From:   Won Chung <wonchung@google.com>
Date:   Thu, 31 Mar 2022 01:38:34 -0700
Message-ID: <CAOvb9yiO_n48JPZ3f0+y-fQ_YoOmuWF5c692Jt5_SKbxdA4yAw@mail.gmail.com>
Subject: Re: [PATCH v2] sound/hda: Add NULL check to component match callback function
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 12:27 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Wed, 30 Mar 2022 23:19:13 +0200,
> Won Chung wrote:
> >
> > Component match callback function needs to check if expected data is
> > passed to it. Without this check, it can cause a NULL pointer
> > dereference when another driver registers a component before i915
> > drivers have their component master fully bind.
> >
> > Fixes: 7b882fe3e3e8b ("ALSA: hda - handle multiple i915 device instances")
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Signed-off-by: Won Chung <wonchung@google.com>
> > ---
> > - Add "Fixes" tag
> > - Send to stable@vger.kernel.org
>
> You rather need to add "Cc: stable@vger.kernel.org" line to the patch
> itself (around sign-off block), not actually Cc'ing the mail.
> I edited manually, but please do it so at the next time.
>
> Although I applied the patch as-is now, I wonder...
>
>
> > -     if (!strcmp(dev->driver->name, "i915") &&
> > +     if (dev->driver && !strcmp(dev->driver->name, "i915") &&
>
> Can NULL dev->driver be really seen?  I thought the components are
> added by the drivers, hence they ought to have the driver field set.
> But there can be corner cases I overlooked.
>
>
> thanks,
>
> Takashi

Hi Takashi,

When I try using component_add in a different driver (usb4 in my
case), I think dev->driver here is NULL because the i915 drivers do
not have their component master fully bound when this new component is
registered. When I test it, it seems to be causing a crash.

Would it be okay for me to resend a new patch with the flags
corrected? I have mistakenly added Heikki and Mika as "Signed-off-by"
instead of "Suggested-by". I am sorry for that.

Thanks,
Won
