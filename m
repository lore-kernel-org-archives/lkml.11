Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF44EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Feb 2022 16:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236407AbiBPQ0C (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Feb 2022 11:26:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbiBPQ0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:26:00 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7560244669
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:25:48 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id q7so4311766wrc.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=edjWIVwhuFt91Pw8VH5r8zVVg9dmeIMhzSsEafLiRtA=;
        b=Bz+Qqu4IXSx730AZVKjQ+tSbjx3K065dVk42DzZStFsMJeVzGf5QOHzZJF82rFTCem
         TMjDINnIfN0nvwsGdW6tdDoeBadcySeK1ISjNOOk3n8IPOfYtjjwxEEjUfUFXx0lYy6E
         AlZxswqxDiRH5x67iSgn5C3rpxvGjboRdkcw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=edjWIVwhuFt91Pw8VH5r8zVVg9dmeIMhzSsEafLiRtA=;
        b=kUY3llV++sEFDdjyJ8RlBlhcAZujP5be/anT6+vcdYkpfbA1++Av0H2jy5CPoipftk
         uzFIJkqwQZzgsBUvdc3PLfpLEeCbCgqQZZR6Y+ZRXgqXeyo3Othk2Q0OQ3Wy1ONca92p
         1j6vCrkK9YjVjCUIp7MeBdNX2Aqo/qtogbUkkQ/og9w9S/IOd0PGiEieZU1d1wI4Paed
         f82XnB/U+uBki1MksN90vY8Koat5rrwvX9de6f9y1rvoZ6O9erKQA/+B5V8Z6nLr3RaP
         vUqtCbEtAigb29hPPg8RNhGVtjzlcXdqBtIdWfCl27ohPvxsU7H2rtWveQ1fj18YMIeT
         n7Xw==
X-Gm-Message-State: AOAM533HgfWjTZCZe2UArhhxRYZXu/5j2b6JGKWxtxljVGU3jHsskfsO
        ZBGMc4XAyAjHg6YhbJ0Z+yF6Z1rkrG3OlF/28vbrfg==
X-Google-Smtp-Source: ABdhPJwIrmtqvQuYmhkiDOdoG0D0y+HSySX6VjTkn4+bYwYMgK5SG17ByKMMb8hoVS8664AKZTnZv55Ov4u3W8BRiK8=
X-Received: by 2002:adf:ce8f:0:b0:1e4:bcd3:3aa6 with SMTP id
 r15-20020adfce8f000000b001e4bcd33aa6mr2752349wrn.561.1645028747340; Wed, 16
 Feb 2022 08:25:47 -0800 (PST)
MIME-Version: 1.0
References: <20220211012510.1198155-1-swboyd@chromium.org> <20220211012510.1198155-2-swboyd@chromium.org>
 <CAOOzhkpDvR14-D9YcZzbAQdQkDmas_XUtV-CLBR7+a3AuxgstQ@mail.gmail.com> <CAE-0n52aueW5N+d2d6tjWtca31werhwk6-6yqDm-XibtTfJsTA@mail.gmail.com>
In-Reply-To: <CAE-0n52aueW5N+d2d6tjWtca31werhwk6-6yqDm-XibtTfJsTA@mail.gmail.com>
From:   "Sean O'Brien" <seobrien@chromium.org>
Date:   Wed, 16 Feb 2022 11:25:36 -0500
Message-ID: <CAOOzhkqhQdO3LvfqW+sizLW3eTFnmYiXMrYk3oAKa8ynjyLJhg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] Input: Extract ChromeOS vivaldi physmap show function
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     benjamin.tissoires@redhat.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 9:09 PM Stephen Boyd <swboyd@chromium.org> wrote:
> Thanks. Can you provide a Tested-by: tag with your name and email?

Yes,
    Tested-by: Sean O'Brien <seobrien@chromium.org>
