Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8AFC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Mar 2022 20:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238420AbiCAUab (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Mar 2022 15:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238406AbiCAUaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:30:21 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB05A0BDB
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 12:25:48 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id u20so28870126lff.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 12:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PdjKf/a3poLbp/gbxt+Rqw8zr6wpWCPEMBt3Gdf0vVY=;
        b=K7n4eVxkkqxw4LVOCYp6qjz4Lrn8nUG8scqpDLjNdEqFXZMud6qwqiSVAz5st7Yg7d
         vC2q3Dqvtvzi4XIPeFoMoc2+dMBhZ16QOgzUWOKknYeZr7LRcjqzvrH7Gver9/sEKKQs
         f6/zgOwraRIJv6M9/T7aFKvmQFpJdJkC/c588=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PdjKf/a3poLbp/gbxt+Rqw8zr6wpWCPEMBt3Gdf0vVY=;
        b=bvsKA3TtWlyE3PbVLuwMs1IxVGbcm4z16vZNOUUhRHJXZbtqF5/njp4Gh8ATIoXLJo
         dT/CTpmYouIflaO7nS+50LGp02i9DGh/NOAgHXpPtTCuUghocI15Vitb4N4X634Qo0nr
         ymFITspldye1nILxppUg2Td0TMBu+pzgJS5A4mWt1oXbr9ukhG7thLe0xtfrL3kEm3Jr
         hyuO3iMmSzZvNIawh/iS7/TBw28slLP/zLFKZM1Up/u0yGKgAoddjr78UNHZqe22ohxa
         oXS0ozeeBBczCfmMDGxPqsUVhgALnCCjWGGxmmHZ4kn9Ex0P2MfiG6mJKE5TuwBlFFpn
         2SFw==
X-Gm-Message-State: AOAM531P1Y4kR77h7KdnI9pWfEH19F/a8TZaAM4w7NoO4ibVaP0PY184
        ogMQoWxBDOM0rflf1FXg7wpl1Q0dF0vkOcMt8qc=
X-Google-Smtp-Source: ABdhPJwaV73f/JlBF4oGNWkm7YI15ZsxU3mb0PrtZI88RRxbgRJ3B/fdbgMSFMJr+BLwCXihnwRkDg==
X-Received: by 2002:ac2:4474:0:b0:43a:7681:8fac with SMTP id y20-20020ac24474000000b0043a76818facmr16723211lfl.316.1646166343529;
        Tue, 01 Mar 2022 12:25:43 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id d15-20020a19384f000000b00442ea20f36bsm1654682lfj.299.2022.03.01.12.25.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 12:25:43 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id p20so23494014ljo.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 12:25:43 -0800 (PST)
X-Received: by 2002:a2e:aa1f:0:b0:244:c2ea:7f20 with SMTP id
 bf31-20020a2eaa1f000000b00244c2ea7f20mr18277669ljb.164.1646166026459; Tue, 01
 Mar 2022 12:20:26 -0800 (PST)
MIME-Version: 1.0
References: <20220301145233.3689119-1-arnd@kernel.org> <20220301145233.3689119-2-arnd@kernel.org>
 <CAKwvOdnkfuT_w_0RNCb+WTKJ+282zLKmhB9UNG=D-UFz9VkUng@mail.gmail.com> <CAKwvOdn-PrCUPe2WzLv18AH3=9DjtFES+r=M1DhoQivy8sHm-g@mail.gmail.com>
In-Reply-To: <CAKwvOdn-PrCUPe2WzLv18AH3=9DjtFES+r=M1DhoQivy8sHm-g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 1 Mar 2022 12:20:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh4OdQANe7TLYGdPWUub0MEdbGDr72wpATHxypaSEGAyg@mail.gmail.com>
Message-ID: <CAHk-=wh4OdQANe7TLYGdPWUub0MEdbGDr72wpATHxypaSEGAyg@mail.gmail.com>
Subject: Re: [PATCH 2/3] treewide: use -Wdeclaration-after-statement
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Marco Elver <elver@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        David Sterba <dsterba@suse.com>, Alex Shi <alexs@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        llvm@lists.linux.dev,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 1, 2022 at 12:06 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> That said, there's a few additional places that reset KBUILD_CFLAGS.

Yeah, the boot code and vdso code often sets its own private flags,
because it's _so_ different.

The generic kernel CFLAGS often don't work at all, because that code
may be doing some truly horrendous things.

So I agree that this may not catch all the kernel code, but I don't
think it's much of a problem.

             Linus
