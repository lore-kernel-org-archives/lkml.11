Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9C2C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 17:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbiBXR5d (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 12:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbiBXR5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 12:57:20 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB6D4BB8B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:56:48 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id g39so5204490lfv.10
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TMceaaXnV0bDbvJSiP9ofcWLsC6a8Q6tO19sa8u3A0o=;
        b=bYR2fdhQXZXtx52UFpQTKptu0+tKWepDRJYaSASQht99wn3VdFnIB4nTaKEwcTSwdj
         9Y87wvLFaLqj5V5tKYfUmequSJmSMbEEC0W2q5XZLBYUTZVR06/y19JLh4eq/k4Gribx
         M7XZANv8s8gcguKECoEtGWenFqs3zgJrcWIXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TMceaaXnV0bDbvJSiP9ofcWLsC6a8Q6tO19sa8u3A0o=;
        b=KIPy+x5h8dtY/gVDUUibPm0UgpQ2LrmmFme7xYYJ66h2taH5xR3LH9JzVSTBtbk4AH
         2G0ewSYCxz50YXjFM/5iFooNi7ZHHGDjhPvTeGbVwWrbXf3B4og7ioK5jlkQfjrsHCTh
         ojcz0WVWg7Oi4lElilQVW1nnIZdTJYDHGY2R5qGeroNx1J3eRnPjxLl6YCAJmON8Zb1D
         /HaloESumJWmBp6WsX9fxstaXxFY/6Az8qboRSca5VZBDmFMSOoCkoz3eU+y30gIM87U
         /t4WVIYwUHEIbFoUGemjOJYCB7O4tfLfa6qWN9gJ5OgxZ4tkapamvAApim0CpmhvS8mw
         oxeg==
X-Gm-Message-State: AOAM533mXkCkMLeKg+Tj1H2PeiijQ+TJqwm6CVk1zzhOlqfIGhNd7aFX
        AqggGbwtR8yyJwXxE5H8aN2mhHSUWChwuz5eUO8=
X-Google-Smtp-Source: ABdhPJzT2jVdsvn2vNqgeVtm7SN29d5AplgTqY/hl92GToSTiOhWZlLEB8jpq9ZFRDUotY33ewZQnQ==
X-Received: by 2002:ac2:4893:0:b0:443:3b8d:b54f with SMTP id x19-20020ac24893000000b004433b8db54fmr2370822lfc.73.1645725406673;
        Thu, 24 Feb 2022 09:56:46 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 1-20020a2e1641000000b002463630a11asm23294ljw.140.2022.02.24.09.56.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 09:56:44 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id m14so5246355lfu.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:56:43 -0800 (PST)
X-Received: by 2002:ac2:5313:0:b0:443:99c1:7e89 with SMTP id
 c19-20020ac25313000000b0044399c17e89mr2345835lfh.531.1645725402991; Thu, 24
 Feb 2022 09:56:42 -0800 (PST)
MIME-Version: 1.0
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-4-jakobkoschel@gmail.com> <CAHk-=wg1RdFQ6OGb_H4ZJoUwEr-gk11QXeQx63n91m0tvVUdZw@mail.gmail.com>
 <6DFD3D91-B82C-469C-8771-860C09BD8623@gmail.com> <86C4CE7D-6D93-456B-AA82-F8ADEACA40B7@gmail.com>
 <YhdfEIwI4EdtHdym@kroah.com>
In-Reply-To: <YhdfEIwI4EdtHdym@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 24 Feb 2022 09:56:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh87tDvKyuTF+NXBPLrRt=bOszP_N2nf5nkf4knX8SxrQ@mail.gmail.com>
Message-ID: <CAHk-=wh87tDvKyuTF+NXBPLrRt=bOszP_N2nf5nkf4knX8SxrQ@mail.gmail.com>
Subject: Re: [RFC PATCH 03/13] usb: remove the usage of the list iterator
 after the loop
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jakob <jakobkoschel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergman <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 2:33 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> So, to follow the proposed solution in this thread, the following change
> is the "correct" one to make, right?

That would indeed be my preference.

If we ever are able to change

        list_for_each_entry(tmp, &ep->queue, queue)...

to simply declare 'tmp' as the right type itself, then the e need to do

        struct gr_request *tmp;

outside the loop goes away, and this kind of "set a variable that is
declared in the outside context" becomes the only way to do things.

                    Linus
