Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A75CC43334
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jul 2022 00:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233814AbiGVA1x (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jul 2022 20:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiGVA1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 20:27:49 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B667089E84
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 17:27:48 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id mf4so5957026ejc.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 17:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g8LjdHcJfvd8YmhDIih7Ks8me5dObMZ6e8AXUp56raU=;
        b=BsQsfvGgyeYZi82xZDqX+P2W04pN9KR+LTK93LlfoKtMiWdcqitTz7n0a+wzMZnBmX
         0+oJ+HOrxD2UUnQnT56VBQXbsubOZ78EGgbxOpvish0OgPrJwZkbIfVACV8LYP1B34eE
         mmjGM5Jjk7CnvOuki/Rcc5RTGHkkSmK83+qrpnN8ttq7vYZ/XKSHKu6RxSa7yQuwfIXh
         ELGGEfmRamNz7ztRLV9gmbmLWhDRWFrlJCXnKX4EDrzUw7FaK23Dnpsoas6vd0MRDdpS
         b72uXbgecKTKvEREvvKry/SKURjD51wglq4SZDLLzf8tOS9GUopBcbjukjBxnkQQaQYV
         gjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g8LjdHcJfvd8YmhDIih7Ks8me5dObMZ6e8AXUp56raU=;
        b=YlKnE8Mh6O1nmbjrTUrRhGNKENTiYSe9KJn3AeA62HeD5wGGj7PALjXQypnpRRRJx4
         uma//iYw+jZDRy4MbbZjewB4jg4X+SCNc6AJYZ9gO1YFC7WX6MhqFbSo+Gyk27zPPsCj
         d3W2hnbgNP1zgikA4vsLyRNxVfgbzHLjVpNcVeiZ3bnnY283BY3lB7Wjb4W2K6CDsTLM
         /u3pSM0XiJH/2O+Jm6NwKcB2tlvjG1O3eIVcnUsqL/9e1WDmShtQUr1iz6rEfr2Pmray
         zgx2fhAuNHFnDXlrovtpx+hUD0QigYVqPpUa0RF1TWI4N/hA2mCowoIt2Jd4XoKazaFW
         Q4rw==
X-Gm-Message-State: AJIora/hENjsD+5OYfaBPdzcbpxhF3iEHIMZlDsRIdoltZwJhJr35R7U
        S7cIL4RO0Y67UCNSTzhqcKg6rTRBReM+JmLu44rISw==
X-Google-Smtp-Source: AGRyM1vq5VWTUYVzBMVm+KUthT2XGD1FCuiW4X+F6LzMCRExEnmP+kSdpX9emtp7LBfHWwPcOPS+QGObA1ckEX9DS50=
X-Received: by 2002:a17:907:2c75:b0:72b:3431:2a0a with SMTP id
 ib21-20020a1709072c7500b0072b34312a0amr1001744ejc.234.1658449666967; Thu, 21
 Jul 2022 17:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220721081026.1247067-1-sadiyakazi@google.com>
In-Reply-To: <20220721081026.1247067-1-sadiyakazi@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 21 Jul 2022 20:27:35 -0400
Message-ID: <CAFd5g47jfm8dZ=3jwdy2Vhy+PgAW8JLAPmikhAUVTc-udKZjNA@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: kunit: Add CLI args for kunit_tool
To:     Sadiya Kazi <sadiyakazi@google.com>
Cc:     davidgow@google.com, skhan@linuxfoundation.org, corbet@lwn.net,
        mairacanal@riseup.net, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 4:26 AM Sadiya Kazi <sadiyakazi@google.com> wrote:
>
> Run_wrapper.rst was missing some command line arguments. Added
> additional args in the file.
>
> Signed-off-by: Sadiya Kazi <sadiyakazi@google.com>

Aside from the small nits pointed out by Ma=C3=ADra and David, this looks g=
ood to me.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
