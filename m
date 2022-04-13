Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C267C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Apr 2022 07:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbiDMH6g (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Apr 2022 03:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbiDMH63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 03:58:29 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E3A4DF75
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 00:55:59 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-d39f741ba0so1170531fac.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 00:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=saiO3xozlJfnjeF9niNY9jgioqx8n3ye+SErnO1w2gs=;
        b=D0vsNOnLvDkZjbwXhpdTabtDhPyZOg8Y1ofMWzyXe0Mb7aGjTX/+uylpL/S67Htvx1
         /dWN0ijx0A9gGD8SDAEi3uu4jZFSaB+JR45xYRUHI0IyYVEgNKLwFIzOLkbKOcW4r7DG
         D2fkJs0SlXOi2ulq9gSAulNu7N8CdNeJ4bJVHYCWjkmE3pFEEia5V2e71CYHYduqDvXL
         XfNOCxU8haNVm5TKgtvV2RYv/3bS5Te6RIH0QN+lyx6WOrXAkYshakigN33Vuvn4I4F2
         DwXDNh6Y8QSoLVZjGQuymj6LOlpr/vXOd+hzx+fbY/xXIebIZ/sH8YZ6TZG0NGMK1W5Y
         +XDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=saiO3xozlJfnjeF9niNY9jgioqx8n3ye+SErnO1w2gs=;
        b=tq2eP+n8SM1eQN0xFv2o0ODmzYhzFUCqj5zlifSJLArnKFEycR/TOKI/uqNOYPDBjl
         rNHOllLHxNPFZ0CAa3jTLPsDWrFLNPjRnTtxgLk6fX0j7lAQIKcbk+ehSFMPtq8aNxnK
         Ohcs8QX2F4wT1hvP0FGQBi9kpej2WtfnfVjTjYJ9oxyf3QBVmusSqGGM6Uyl/LAS0utx
         E9YZtxuWX3LWb8P4bO1VJAP2szjFqAchFyDhuzVJeOXfaDDMYruk9hAabPiMJyrgTih2
         l8ZKtGZc+x7J8QshCfKakMi94Jvs9lOslaow6eXZ47mcE8u+r+Nj5ypx30zREIURwtA3
         iYIA==
X-Gm-Message-State: AOAM530Llx02eUXk5v7xWZ4leWTS93s/nqOryeH9SPfDSM+pp6kx0CzH
        IC4ePDif1dOOTjzQfXqmsfbp8kxKg5qaahx36AMsMlcJKG8=
X-Google-Smtp-Source: ABdhPJxPj0eQgvjGzIpbk7b1VurrgQS15VSGX4YNn+xE8l0wtLgFbwuHIb91I5L33432iNY26zyCtR4PFcpWny9SOpY=
X-Received: by 2002:a05:6870:b4a9:b0:e2:caee:a38a with SMTP id
 y41-20020a056870b4a900b000e2caeea38amr3793027oap.138.1649836558607; Wed, 13
 Apr 2022 00:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220413071137.4023184-1-rfried.dev@gmail.com>
 <YlZ7fQIpXNJSbd+P@kroah.com> <CAGi-RULbkLS0wRQni8mQ0Dp_dAGuRSj96TmqD7oD+Tj=zSo3Gg@mail.gmail.com>
 <YlZ/tK/51GiQI8uP@kroah.com>
In-Reply-To: <YlZ/tK/51GiQI8uP@kroah.com>
From:   Ramon Fried <rfried.dev@gmail.com>
Date:   Wed, 13 Apr 2022 10:55:47 +0300
Message-ID: <CAGi-RUKVZyGaPBYNitnnjEMQ2_p3gTSUaMuKB7d8=E6-4UdBaw@mail.gmail.com>
Subject: Re: [PATCH] uio: make MAX_UIO_MAPS & MAX_UIO_PORT_REGIONS configurable
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 10:46 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Apr 13, 2022 at 10:40:09AM +0300, Ramon Fried wrote:
> > On Wed, Apr 13, 2022 at 10:28 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Apr 13, 2022 at 10:11:37AM +0300, Ramon Fried wrote:
> > > > MAX_UIO_MAPS and MAX_UIO_PORT_REGIONS are hard-coded to 5.
> > > > This is not always sufficiant for some drivers.
> > >
> > > Why not?  What in-kernel drivers need more than this?
> > Obviously kernel drivers don't need more, but I'm developing a driver
> > that needs more.
>
> Great, let's consider this change at the same time you submit your
> driver, otherwise it doesn't make much sense now, right?
NP.
>
> thanks,
>
> greg k-h
