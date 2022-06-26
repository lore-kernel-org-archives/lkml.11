Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64FBC43334
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jun 2022 22:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbiFZWdE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jun 2022 18:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiFZWdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 18:33:03 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDBA2DD3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 15:33:02 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id o9so10595004edt.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 15:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F8k/W+Y55YNpW+5hRXZc8dzAY2Bfqx0VzAHHDvBJbEQ=;
        b=EvzVxegXdnLpT4J/m79ocqLBhfICA3aOveENKgLoHTw2PewgZmqHZnOIyXjjdpgpoD
         q4pRwTMX+1sNXWX9YY6+gdMpG+wMluN9CmJs2UQBpccf5/+lqtwf4FmVS1sUGysODiOD
         fCQdOtjUlBKnqoFGWf5tpVOFFCcA0No1aMFAmlSwUVM7eRt7qBY/SYMlrgUyZW2EJ2Ju
         afSQFxf7TJTlNqRsecYmQrm+75SGqFT1EmvywuDZe2H1c4cvO72OE+ehHcltGNl8lckk
         IPq9J+wKuY2NoOD5IcoNljty1ZOyC1d80Hk+gsVvRhdesNfr8YYN10wioSgrZ0wZpYHR
         ll6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F8k/W+Y55YNpW+5hRXZc8dzAY2Bfqx0VzAHHDvBJbEQ=;
        b=NhSodyV6gMBSiOwO32vHbzsJ57KGM+Xa7s956n5GV8p6lR2f/Bp5Gln3ILmaCOAmj5
         Ij1K79bGFyrQHrgpuZAi+LUcwqOyX/Ah8y++J0HHWnktaIy8YWen6451Fm9JZE5oriUd
         83npGGt0D/y9UyH2jVhY0c2PxT1d85Movymgvn9HkujYIu1Yvbh1O7BTe43njnxoQk8Z
         3YEdYQEx19WNEZIrAanqPZ0rRcrmCLCjiBTgFG2/j6tyj9fGejPFoWDXJm4baT3WGUwc
         8uhl2iYUDG2GETdv9aR2w3xsXdptdi+Je0v7y/BVtTtxqjIt5XM3QfXApLB4UyWTcpSA
         yZYA==
X-Gm-Message-State: AJIora9BdRGlXbJZVNp//jxMnh223ZnxBYNBduV7/GP/RwKOO5B/HqIZ
        VKW7jX/dAKYgN57VGrc58wlD6henzZ7uHJ56EeE=
X-Google-Smtp-Source: AGRyM1tllWJ+xUlV0MtVwcue9xV0he/QRwjFk8QXLH+yTZ9inE1uvC3fO2UW4H0Avwx7eoYrlZg6ZCtCqYNHHS9gr5Y=
X-Received: by 2002:aa7:c542:0:b0:435:75e:8a7b with SMTP id
 s2-20020aa7c542000000b00435075e8a7bmr13122141edr.108.1656282780812; Sun, 26
 Jun 2022 15:33:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220617072723.1742668-1-narmstrong@baylibre.com> <20220617072723.1742668-7-narmstrong@baylibre.com>
In-Reply-To: <20220617072723.1742668-7-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 Jun 2022 00:32:50 +0200
Message-ID: <CAFBinCB=RJeaqVi+d6gGAsQTWAU68iFF6T9bXAQVYUWKxgiYaw@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] drm/meson: add support for MIPI-DSI transceiver
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Fri, Jun 17, 2022 at 9:27 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
> +/* [31:16] RW intr_stat/clr. Default 0.
> + *             For each bit, read as this interrupt level status,
> + *             write 1 to clear.
Do you know if an interrupt line from GIC is routed to the MIPI-DSI
transceiver? If so, we should make it mandatory in patch #1 of this
series (dt-bindings patch), even though it's not in use by the driver
at the moment.
