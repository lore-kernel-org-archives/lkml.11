Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BF8C433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Jul 2022 17:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbiGGRKP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Jul 2022 13:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbiGGRKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 13:10:12 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00355A2CC;
        Thu,  7 Jul 2022 10:10:10 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id k30so15840706edk.8;
        Thu, 07 Jul 2022 10:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wBoo1+KN3lb+lpDB0Syq/Rou1NpSxHqNtLRo+v6m2rM=;
        b=ZaFq8+jCKdmMvlQcL2nIxjtMSiRHdthbQLXap4pnuLNPUlmnf9av781xZIzAtedTa5
         G0YMQEj2IJCZzHGA0+3uTilwlraP442vpiKBxS46hFirDotMSiq9QtrTM00RMS0v9rRe
         p1lyIJMOQlOFoyprbwjmyB9kXkvMXo+CpkFR6qOecF5f6uDGMFlEKNmOPUZmZZHQk8IS
         fwoYi9BU9RSOgbuxPknkPb1mRfNFJF6pw4XevTGJLKfXdxaox9GKARk6fK8Dh2gCimLB
         kDQc6hwqVPu91qWBYaXJPPacNpJjXYTryYlUAS5fTSgKv0heXT2gQK6DD0hfF/CVMJyL
         7Lpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wBoo1+KN3lb+lpDB0Syq/Rou1NpSxHqNtLRo+v6m2rM=;
        b=VkNTPMlUBWTnxWzqF7D2wJlJjayWi98qEZVFF0AvCibtuXH9MF1esKttcoflfsV1iL
         1RqDE9YanZDKgUtykqzD/KXULL7J/9K5PLpx9tW0WftqKraPAUtmVVM2nxqhml94ugDy
         9XuJr5MoVKMgOJJeYQd6ss3pe1scwyvLq4ZbU4F6CtncS2UMU/kS0W/j2XNjR2tQmV9y
         YhLnDUSqWvHrJhmKjXzoL8xdNmAsR6dTLEyEpToIValpZBRQR72+BdckmTzGY/myDWR/
         tkHroKsTthTzOo7Pm+1cuKt2c0GNFaVYEuYpeh+v0/VHlduoh9qH9JmjW3rJ9sf4hvs/
         cckg==
X-Gm-Message-State: AJIora+AEnESaiNjVaer+wSJjKNpoWljlg2wQy2Z/wg9Y4G7GgvYHFin
        Rf9zXFC1jz6p0NHhrxlCYRZqbIp9uDpeKuMy
X-Google-Smtp-Source: AGRyM1ttnENExFqRG7KPrp/l2HiUbmKMfR9tBezmMQ91SYdAWrySvwJ3BnhQRqBZwD9AtTks9VhnGQ==
X-Received: by 2002:a05:6402:201:b0:431:665f:11f1 with SMTP id t1-20020a056402020100b00431665f11f1mr63277551edv.378.1657213809516;
        Thu, 07 Jul 2022 10:10:09 -0700 (PDT)
Received: from reki (87-168-253.netrunf.cytanet.com.cy. [87.228.168.253])
        by smtp.gmail.com with ESMTPSA id bm4-20020a0564020b0400b0043a8f40a038sm3821478edb.93.2022.07.07.10.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 10:10:09 -0700 (PDT)
Date:   Thu, 7 Jul 2022 20:10:06 +0300
From:   Maxim Devaev <mdevaev@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org, balbi@kernel.org,
        gregkh@linuxfoundation.org, caihuoqing@baidu.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: f_mass_storage: forced_eject attribute
Message-ID: <20220707201006.746d4696@reki>
In-Reply-To: <Ysb0ZiEveXvmrC2f@rowland.harvard.edu>
References: <20220706185936.24692-1-mdevaev@gmail.com>
        <Ysb0ZiEveXvmrC2f@rowland.harvard.edu>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=92 Thu, 7 Jul 2022 10:57:42 -0400
Alan Stern <stern@rowland.harvard.edu> wrote:

> On Wed, Jul 06, 2022 at 09:59:37PM +0300, Maxim Devaev wrote:
> > It allows to reset prevent_medium_removal flag and "eject" the image.
> >=20
> > The patch is a completely alternative implementation of the previously
> > proposed [1], the idea of which was born after the mentioned discussion=
. =20
>=20
> Generally quite good, but the documentation needs some improvement.

Thanks for your help, I've fixed it and submitted v3 patch.

> By the way, what does happen if someone writes to this attribute file=20
> before the function is active?  Have you tested this?

Yes. This simply detaches the backing file, as if you had written an empty
string to the "file" attribute. This is literally the same code, just
resetting a flag that, with an inactive configuration, cannot even be set.

> Doesn't a zero-byte write also work?

No, the same as with the rest of the configfs attributes.

