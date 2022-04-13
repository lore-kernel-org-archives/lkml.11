Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14EEC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Apr 2022 09:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234193AbiDMJI0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Apr 2022 05:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbiDMJIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:08:23 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AFB4160D
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:06:03 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id m14so1633511wrb.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f4Ur5FuAMtA6xVJsN+nl3/RAKHtJZB/dEjqv/D42SDM=;
        b=E9zncH8fDX4akfa0q887+k3HgURcftW3VOd3P3DKaRcVVy5WhbTBD846cDePAP6rPe
         +w3Ttm3WFE/HtZ9nxnTqGKlzE2nQx0WSKNbmb1UcCDOv9yhUt5WE2+Oy6n20B5S7sNWj
         PINcVdUSSIKc7BTpjDCBRb7h5SKl3EP9tpmiUon0I1W/9LqH2gQTqTtJnGTX0G7sJhFe
         1TyR2T8frmfmVy+Db9tV5J2zMjlCaTJeQAgw+Meb6bniNWCKiGyWGFJbsiSYupheLcJ0
         VyegBwqX9QvW5oOtzoSbBhqqjkZOs5rl7GNp0bBPOwQhDJ75+qI6HFAFhnsHDPxIDAmc
         MS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f4Ur5FuAMtA6xVJsN+nl3/RAKHtJZB/dEjqv/D42SDM=;
        b=LXs7hoCMzJIS2nqLbNk0n5r0WMm+2PEtw7OxCwwEo9zNLW4dxdYrUOnBoWZtr2BfVL
         KWKCR5EX9il4XjirHrybJ9/6/PCjhRGqv8ZJRUOv3vQJV9oQ9yAieEMtOBAOKmAmsdke
         ZQnitoOMRh1GxDlo7EYRlmThzjllXvKJCrxVh/SlWE3B88f1TqRag6UIVGg/pqxLpaIH
         gO8SmLbsg3ISvuj0iu4RLYus3sz10ndThKmxIPGz+upC0Ixf9N3+gmYNgqq41xuEEXhe
         BBIVK2IALYqhSH+6mzdzWRkK6ppFUD0Bwj9+2vwhzZKyWdDPX1gdSvl8JfztyrZdo+sR
         it0Q==
X-Gm-Message-State: AOAM532xpPRvdhOsG22cM15cR6NsNnb1Y6UqbnCTVyKSHdlIFbHB86Fv
        bE81FuDaVWOpUJMJearMwMFzc7KhKdhRceIV1gpxLw==
X-Google-Smtp-Source: ABdhPJyIwwxPJ6LcuXM9IBchpQCcd3b56k+vDKmb4JRXyHcSQ1I6icydynMFl1ioG+SUrUV6KnvsJSVwMsPbpOLncK4=
X-Received: by 2002:a05:6000:18e:b0:207:a221:302c with SMTP id
 p14-20020a056000018e00b00207a221302cmr14318339wrx.120.1649840761707; Wed, 13
 Apr 2022 02:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220413030307.133807-1-heiko@sntech.de> <20220413030307.133807-3-heiko@sntech.de>
In-Reply-To: <20220413030307.133807-3-heiko@sntech.de>
From:   Philipp Tomsich <philipp.tomsich@vrull.eu>
Date:   Wed, 13 Apr 2022 11:05:50 +0200
Message-ID: <CAAeLtUAiF+d5Yj0Dak-hiCZVGe1zSU0k=E630n_BOXkutg6jZw@mail.gmail.com>
Subject: Re: [PATCH v9 02/12] riscv: allow different stages with alternatives
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, wefu@redhat.com,
        liush@allwinnertech.com, guoren@kernel.org, atishp@atishpatra.org,
        anup@brainfault.org, drew@beagleboard.org, hch@lst.de,
        arnd@arndb.de, wens@csie.org, maxime@cerno.tech,
        gfavor@ventanamicro.com, andrea.mondelli@huawei.com,
        behrensj@mit.edu, xinhaoqu@huawei.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, samuel@sholland.org, cmuellner@linux.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022 at 05:03, Heiko Stuebner <heiko@sntech.de> wrote:
>
> Future features may need to be applied at a different
> time during boot, so allow defining stages for alternatives
> and handling them differently depending on the stage.
>
> Also make the alternatives-location more flexible so that
> future stages may provide their own location.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Reviewed-by: Philipp Tomsich <philipp.tomsich@vrull.eu>
