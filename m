Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C128C433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jun 2022 07:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbiFBHNi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jun 2022 03:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbiFBHNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 03:13:31 -0400
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047E8B6E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 00:13:28 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id 14so3077307qkl.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 00:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DTx4+fJmVhIyXMyNirvzWdPuJKhlL8UJzLpiO+xxcus=;
        b=K7CASautd//QO03597L8pkkVdSX98T6VNqlCZYYpGvlo1kkt7dMksP5/7RiVEMGbou
         9Hz2M7kU/dndgDfxPcczVt4esMSC4Cc9CSxvzsAEDHqXtGiCPNPOk7XVgcz+hqHtTR1N
         5xTW7/k2IPksmUXby14WzYOeFw0XoJkdWEK+uoK8L1a8m4+D78c4TkFxxW0LKyh8cqFV
         bmFbuzlPMQ0RPAQ/3bsJUZ/vh8Ha36DVz0Y3wkSTlPr8LMgvvkFrFx7eUaiG582Vc417
         tsQJmcKs9mPJZNzIRbtBFpzTLdA9+4xq43hyvfiMb4/PrHRI2AsTWdZed74WvjWtbbhc
         h0Lw==
X-Gm-Message-State: AOAM530cZsctXLGh8GdQ4DB004wv9hQkV6Q/SaZaPoWh3O1L90UiMaQG
        JoUxnLpYd9BAi4w4yBxw1vArsi4Hd5MCdg==
X-Google-Smtp-Source: ABdhPJxNLzeY4oAAkZMx0aPnA/LvArgLm92qk9g6bv1QxgQ0neAQe19KaemufsxwTfrEX3JrbjzvNw==
X-Received: by 2002:a05:620a:1a8b:b0:6a6:349e:ee9 with SMTP id bl11-20020a05620a1a8b00b006a6349e0ee9mr2226908qkb.143.1654154006896;
        Thu, 02 Jun 2022 00:13:26 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id w4-20020ac86b04000000b00304b506eec2sm2320482qts.93.2022.06.02.00.13.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 00:13:26 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id r82so6779462ybc.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 00:13:26 -0700 (PDT)
X-Received: by 2002:a05:6902:905:b0:64a:2089:f487 with SMTP id
 bu5-20020a056902090500b0064a2089f487mr3810398ybb.202.1654154006045; Thu, 02
 Jun 2022 00:13:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220531174514.1586248-1-laurent@vivier.eu>
In-Reply-To: <20220531174514.1586248-1-laurent@vivier.eu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 2 Jun 2022 09:13:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUbUZU3YA6nDC_LDAfUYQVmHTuCzrCfxDqwF=ZZyR5fqw@mail.gmail.com>
Message-ID: <CAMuHMdUbUZU3YA6nDC_LDAfUYQVmHTuCzrCfxDqwF=ZZyR5fqw@mail.gmail.com>
Subject: Re: [PATCH] m68k: virt: Kconfig minor fixes
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 7:45 PM Laurent Vivier <laurent@vivier.eu> wrote:
> Select VIRTIO_MENU as it is needed by VIRTIO_MMIO.
>
> Add an ending period at the end the virt machine help message.
>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.20 branch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
