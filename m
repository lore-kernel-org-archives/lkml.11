Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1188C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jun 2022 15:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240294AbiFFPI2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jun 2022 11:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240093AbiFFPI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:08:26 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7D82FFE9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 08:08:25 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id n28so19241089edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 08:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ltHPrw2tHLSsWTo0k+1u7PmQZYz53U2tfsTdR1emhZ0=;
        b=PYEYK2LGgrS7dGWMjTgfH3vO0P5+3jFY6Mlx/DEzEnHnZ/iuQlEDObwfakoTUpcibu
         vd6qIuEO/VgUaJvfxY+N8/+tuE13SQ2vM7vUQFC1N3bcF/rqPNCH99NJMe6gMjqEBbmS
         U/Aps48dyjFzYs+skXBeTztDiogn7gM7CXeEhYKaaABaVYheqZ/k/KGYmtS9W4D4fUP4
         b+Eo2wVHQhpBOfd5cZaKED+Qgoht8BZ9pC44phjlnS5AYAa7MYtbHxmIJl4xccSJW/34
         y4Hr+e19KuGjJS0Act9mlY8CCkr7x5BzaZTLIHGIG4JlcLKvFLfFm1ZJqasHg/XJpraq
         fpVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ltHPrw2tHLSsWTo0k+1u7PmQZYz53U2tfsTdR1emhZ0=;
        b=onBEYl2exyXABnO5COAiGEOGoJMU7Fi+3rM6PPpBq7Oc/z//nMLWvOM2kKsXNfZR/e
         akdHTJ1duAH4MyFlDjtd+CWac3bQzmsg4q9Ks4DlXRQqS4noc3fsgmnSN7Tj8Y2G2JSu
         Mow3UfV51geGM6ekoe2SkLlQ2AVKG37V9Ew3l7Rv0PWrEDRDxRGJKUxJId/j9XePtHk5
         DOGfs2kopzYmT4ryjGI8Fja3PCPBiLR3jh6U/8XsykepA6t8x+DAXurF5IabQA0n3rPA
         BeJjWvXuJyqImY6EgeSAsmyQji55H+v6eqZpNPTkf24qkK16RBWyM9nY4zQxuMtDTPYS
         211w==
X-Gm-Message-State: AOAM53255tNyNBgIrpfj56JI54ZwCkoqTZ03tzaQUyz0Foa4v4xf/A4k
        r7knXFaiVZhrQ00nAQYmC8AJbUIOjKQ1Eh5/rLakBw==
X-Google-Smtp-Source: ABdhPJzf5OF/qpPmN7iuEmA7zH5tfCW6VdJVV9OhP5EaSKcTkm9P7d8+GPRtwRVd09FJhu/nPZhR9vJPqPpx0pJyBLo=
X-Received: by 2002:a05:6402:2687:b0:430:328f:e46b with SMTP id
 w7-20020a056402268700b00430328fe46bmr15075923edd.33.1654528103838; Mon, 06
 Jun 2022 08:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220606141051.285823-1-tzungbi@kernel.org> <20220606141051.285823-2-tzungbi@kernel.org>
In-Reply-To: <20220606141051.285823-2-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Mon, 6 Jun 2022 08:08:12 -0700
Message-ID: <CABXOdTdiBBf4Q+_Tv_BLSQtZ=1_2E2iHinnvpmeoUeRUU5W-jQ@mail.gmail.com>
Subject: Re: [PATCH 01/13] platform/chrome: cros_ec_commands: fix compile errors
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 6, 2022 at 7:12 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> Fix compile errors when including cros_ec_commands.h solely.
>
> 1.
> cros_ec_commands.h:587:9: error: unknown type name 'uint8_t'
>   587 |         uint8_t flags;
>       |         ^~~~~~~
>
> 2.
> cros_ec_commands.h:1105:43: error: implicit declaration of function 'BIT'
>  1105 |         EC_COMMS_STATUS_PROCESSING      = BIT(0),
>       |                                           ^~~
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  include/linux/platform_data/cros_ec_commands.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
> index 8cfa8cfca77e..a5b749a85707 100644
> --- a/include/linux/platform_data/cros_ec_commands.h
> +++ b/include/linux/platform_data/cros_ec_commands.h
> @@ -13,8 +13,8 @@
>  #ifndef __CROS_EC_COMMANDS_H
>  #define __CROS_EC_COMMANDS_H
>
> -
> -
> +#include <linux/bits.h>
> +#include <linux/types.h>
>
>  #define BUILD_ASSERT(_cond)
>
> --
> 2.36.1.255.ge46751e96f-goog
>
