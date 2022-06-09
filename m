Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A373AC433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jun 2022 07:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238033AbiFIHKv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jun 2022 03:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiFIHKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 03:10:50 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAF924249E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 00:10:49 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v14so4822182wra.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 00:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JJz/uKfPsh9RRifdT1nn+CMGqnTBCL20lTm/X6d1lqM=;
        b=jsNs38uwEJLDzfg6iOVlGcTuNTHg/2wCkchmIoHgHbUnNvDYT9jX4odCdFR1X5HOVd
         1oO4u6OSo5Jly3z6iRdb2d85wNER+NQ1fcTpyL/ZvioaAqRUTHW4wLmm/yLSNaqDyCJw
         DYA3VByqbOklwDmNBCd3Tz6Zrj1nqbAVHzPmPMudE1tO4p289AF0MZLZi0bRdM+b9D9W
         X+2K8SxU4t1PW9cq/KRjsO+qOEDxsDmujcMAc1jb2Z9Ldd28793q6hEIT5lwZiCcJa4d
         8VCA8ZF12pUDq5TbPSNRKxaotT9xQSNfqV68lphOy6+zyN+6gT46IGjOqRORnl7U6oh/
         dA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JJz/uKfPsh9RRifdT1nn+CMGqnTBCL20lTm/X6d1lqM=;
        b=BHdT59X5ZbjKWAhm4f8OFPRUYPf67XemCAEVVEUDhBQL3w6hv32mZaIv+G8B6+peLb
         YgxKbp9A0Lju5NDGl4D6HRFW9PqbV7qfG+8Gv91fcQGWvCEhv4NhIVXoaCgcvrSXS0gF
         reYqMFaJI9ZA/VRFdLs1ULBHVD1lMsTK7WTW6G3/DVa+p+3hvDsIpVprx/BnDiSoH9oA
         JEX1M7QgK4im1EpEQoRCkLtRnoChCmy+6EXBR+8Jh8Lj/KYWPYWK7LeSSVd1RHwkWUmN
         qYHnKGQzyiUbrRsqXRBAb97dSteGc8Rf3t8oVCdXHPSNHUlaRc6Y+Mff7Y/E/AqQR7gO
         Ordw==
X-Gm-Message-State: AOAM532h3XMmDdGxzDEDjvPKIpWS0cMdgDmnN5Ms48Y7l8aqtNc7YZzP
        0PZnJCFFI5MzwQK4+tHuSq8mw/IgKGL7/n0RcjLTkg==
X-Google-Smtp-Source: ABdhPJylcxfa8lk6sZMPzVdU/PBo3dJQN7FnVwb7dERZQ14FpQB8ahwTtYVRJy9R0o2eeSEMfYKbluxOe47pBBMdUwM=
X-Received: by 2002:a05:6000:2a4:b0:219:2aad:51ce with SMTP id
 l4-20020a05600002a400b002192aad51cemr5208677wry.719.1654758648006; Thu, 09
 Jun 2022 00:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <CALt099+y4-kJ0OqVeKaAjAbs4inOkR-WE0FmyiJRDc1-Ev9UKw@mail.gmail.com>
 <20220603124956.GA18365@lst.de> <CALt099JqRXwsGnq_DmHmnwPyB0K9Y+-BZUG_YoGxOg7G7ZZh9w@mail.gmail.com>
 <20220609042736.GA31823@lst.de>
In-Reply-To: <20220609042736.GA31823@lst.de>
From:   Michael Schaller <misch@google.com>
Date:   Thu, 9 Jun 2022 09:10:11 +0200
Message-ID: <CALt099+_EoSmigM5LizV8g7KFY=n0dcfPv4Ycw=YrCDvhJELMg@mail.gmail.com>
Subject: Re: New partition on loop device doesn't appear in /dev anymore with
 kernel 5.17.0 and newer (repro script included)
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 9, 2022 at 6:27 AM Christoph Hellwig <hch@lst.de> wrote:
> Any chance I could trick you into submitting your reproducer to blktests:
>
>    https://github.com/osandov/blktests
>
> ?

No need to trick me. ;-)
https://github.com/osandov/blktests/pull/93


Michael Schaller
Site Reliability Engineer - Software Engineer
misch@google.com

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
