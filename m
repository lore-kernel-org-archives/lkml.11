Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8EAC00140
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Aug 2022 13:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243057AbiHHNm3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Aug 2022 09:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243107AbiHHNm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:42:26 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2365D94
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 06:42:25 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id y11so6364968qvn.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 06:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=WHqINzLhmaYyjnmYHia2mswEQhzcGf6Jk2Qbq/Eb48E=;
        b=W3xDRvmsgm1Vt2z6FK62emTGBQhoMP3DaND2sgRdwLfbe3qi/7EECCoEzCE8/z064D
         MolIZ24n5fhy65oilSAz9U+86v6bVZUTP+ClsRwSvxtfwc0jsN/ZSv7s/oClVjbyfk8O
         DMEl2tpu3wgtPTSrtDNj5OzkF8qcT9/4oDIOUanrcK2ahcLUBhtj8RkJh1ggTmSbcGiO
         71vE+9sUc9tdvJvJtnAldpWtYx/jz3yBir2jm4HzdD/rZxiXOi8UHYpmXYkI3RPEC22U
         Lx37DrhTg0V0QmmpYn0v5mqKhvkNr0sU3yXMtY4p9dtTgEpT+mQaVrwpZvuMihYIFlk7
         FPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=WHqINzLhmaYyjnmYHia2mswEQhzcGf6Jk2Qbq/Eb48E=;
        b=vFSp6h79K0BFVt+8M38HaqDoIzmT0De/Xu3q7iMhUpx/MhJi0S0zhatuRa9MD8+fwC
         uou40ieP3fzd4MNbl/FgA/MKxFRIgrW6KAHjvw9zki5DanVtTkDiNJ6yy2Y941eum2NO
         KjsbRngHqGkQ9KDeLbX4kNNMnF5ZKwLY/Hir48WF3x5UenQ3Feq0F4q2vNYILmMRC8pj
         rP+T3J1hEgfGjR8wnfQ6yj3Sow8+kl/8GGtxL03uQd3yeuilS/VY35ml7VTLTwESXkTn
         HmbbEY56Rgy8QRFFMKZknPZdvKHE95OoWafo5+OookUmObaEYc/7zdc2fX+RmapIM4Qg
         FhVg==
X-Gm-Message-State: ACgBeo1FQ25rh/qgATA2P27mZe0LhlHcUfSNOLRdGCYN3OIuvDDVodFL
        VAoLMksDVaEhukDcWv928xYlYpMLW27o4vB6RYw=
X-Google-Smtp-Source: AA6agR7dks4du9BgNBglcrxCIA2bLF27UnPjlKSMGe6Wqn1VtmjSMnJC4cVbanzVPbTgJVxy7dzxsiqme81LZuWx4WA=
X-Received: by 2002:ad4:5baf:0:b0:476:6a9e:b5e1 with SMTP id
 15-20020ad45baf000000b004766a9eb5e1mr15945558qvq.64.1659966145015; Mon, 08
 Aug 2022 06:42:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220805205321.19452-1-andriy.shevchenko@linux.intel.com> <YvEKgkhRWCKtXdD4@sirena.org.uk>
In-Reply-To: <YvEKgkhRWCKtXdD4@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 15:41:48 +0200
Message-ID: <CAHp75VeeZAgKdZhJffNouFh26rwGzmqGuJX7bcObSVV+dFS-tA@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] regmap: mmio: Don't unprepare attached clock
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 8, 2022 at 3:19 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Aug 05, 2022 at 11:53:17PM +0300, Andy Shevchenko wrote:
> > The commit eb4a219d19fd ("regmap: Skip clk_put for attached clocks when
> > freeing context") oexcluded clk_put() call on regmap freeing. But the
> > same is needed for clk_unprepare() since the regmap MMIO users should
> > call regmap_mmio_detach_clk() which does unprepare the clock. Update
> > the code accordingly, so neither clk_put() nor clk_unprepare() would
> > be called for the attached clock.
>
> regmap_mmio_attach_clk() prepares the clock that's passed in, we should
> undo that when detaching otherwise we're leaking a prepare (as we do in
> the explicit detach).

Why do we allow the user to avoid explicit detach? What is the point
of having that API in the case we take care of it?

-- 
With Best Regards,
Andy Shevchenko
