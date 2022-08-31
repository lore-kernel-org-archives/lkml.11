Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E03ECAAD4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Aug 2022 21:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbiHaVms (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Aug 2022 17:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiHaVmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 17:42:45 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD36DDB4A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 14:42:44 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z8so11323608edb.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 14:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Wq5i0YmgH9334LpAnFgkB5aalJSWKK3bpzJb9praDCE=;
        b=mfTF9yVOK5jguuRCZORu2pCr2RTpHkNBc9yBija4Pf1/xePOZXiEtQGc3Wl9o06kMI
         d1HHyB8hxMc8I7HmyNW4Q7Gz4MRitaWL26M1wW9+c+4q8dVn9uveMVBLoarytNj/f3IJ
         Ew0+My2eXFagIKqKHyGK+T2MQdCuKCPjWZWvFkJicpZhtIUYxaZ17SF5YRRo+jZEj7to
         +u/fUJdfWgip7dnHpy6fwJHtslMbl1rjZcogKDPihmY6F+DV+jBOxPc0NtRI6246nlfX
         yeq3QmVHY2rp9KKQAPJtU24quoTTVGQNT05MRALXEo9xaH3ZuS8ZOAKs5+5b5ZaRDtM7
         JsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Wq5i0YmgH9334LpAnFgkB5aalJSWKK3bpzJb9praDCE=;
        b=UcJoCHthCcsL2XJvFv6CLp1uByya4vQnTXO7wDjzYNF36X8ntDeBQlw1wHQDiY+sUZ
         /ArNrUfnAFXEiP9bN0axkKCzMC7G2sOktRbDHgCyo2oMZIwxung4Xbh6Xzwj1BC1/0bc
         BMXd6pXcukF/XE6OhgI5Lnwm1WDChcUGjaAxpL8sZC4SLuXU1fXQ26oF5Yp/JQGt4Eyd
         Qu2zVZtHJczPW4uWIIbFCQDF0weQuvkFNuEheLLzGSVBdS4r0g2bLY82z0XWRksUFaTj
         eacncnY7WYP8ed016rnnXz0w7kQSUmg54ElxVqmhAsCoL6dNSAaCPGdyNVBVwp/ki9QQ
         ammw==
X-Gm-Message-State: ACgBeo1HtaxHaVycGxVkbBv93pVHH5uX1x03kQuWGq13qRemY3agnoqg
        V0WE3OlxSDT0/7jLPJCtzPloO6/P4TC1WI4opcKnd5RUFow=
X-Google-Smtp-Source: AA6agR4oNn+8eD34j7SHHqpP6mepwl0PK2xbAQq/hmizD8BGFfCT9yHj6BS+XhFeYIWqCdqHW+d1KZdEk3JRakvgm04=
X-Received: by 2002:a05:6402:51d1:b0:448:bed1:269c with SMTP id
 r17-20020a05640251d100b00448bed1269cmr8675051edd.205.1661982163401; Wed, 31
 Aug 2022 14:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220831212744.56435-1-andriy.shevchenko@linux.intel.com> <20220831212744.56435-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220831212744.56435-2-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 31 Aug 2022 23:42:32 +0200
Message-ID: <CACRpkdaVCYfo1SVhGmQG=rDNqmCDDNZjLUpN-A1ZX0CRAQHgJw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] regmap: mmio: Use swabXX_array() helpers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 11:27 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Since we have a few helpers to swab elements of a given size in an array
> use them instead of open coded variants.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Sweet!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
