Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB638C19F29
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jul 2022 01:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239572AbiG3BiZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jul 2022 21:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiG3BiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 21:38:23 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520C611C1A;
        Fri, 29 Jul 2022 18:38:23 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id k15so12397pfh.1;
        Fri, 29 Jul 2022 18:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ovy+btOzOKwulLfDqtYLHAzCBX/GxmzMASWSRDQazIY=;
        b=DhQjpg7pP6HTPyDeuulxs7XFXfj33z4fVYtdalLrMOLoF5FBpIVY3OoJ6QI+0H9fA/
         sJKjqCISbhZSulvVRa40xuBQFit0ytCfQDsQEN9405BgKUg6Ip+1a0f8Q/YWX2X/0Vhp
         EF8P7jLgWNKqJlUMqx3vY9ZqhehQ2h54QTpOsBmS/9eCsvtH92Bo77nSQic3wosX8iqL
         yI+ue/EoYIKct604pk8TR2WqezbI2SUWbpZMyn9Q0XEiKMHNv5fw0Sp9Epn1wIZZBR+9
         JFMfPwif3yBi9SKnRxi4NPt9/h+6ytM62xHrOQmsMMsIrCz2xew4zQSNTYsZvINLnlvV
         gNqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ovy+btOzOKwulLfDqtYLHAzCBX/GxmzMASWSRDQazIY=;
        b=G76J23vBvzLvjBhfNPKvdN4/cLm/77/xyb7gypc+YvWPBESwZvXf2VB4bKmo7x2yHJ
         YNiDuRDfzgb5CZV5eHr56viIpgBQxzbYBth4oS3yMIMtDBgWQsxOJvxhboG8LBUKnovj
         qDFXNjibAvoNiY6xx1gs36pe+YCtmFDx21civKnAeNTCCs17yHpexjQ8vtiPWAG193Sj
         VP4V8Ctmvc0mgJo6onjhrdFGq3QBuKVNSFvmy37UqBkPQ7xdW0KhYGrE4qloIJlN10EZ
         jzBJgAhGW6nJL7Mkppy1X8UR0ax3j22KQ5LZ3dqQYQ+TccNy3mdq9u8hLjnMwe97m0gr
         MjLw==
X-Gm-Message-State: AJIora987u/TeN8Io23r7liyTiNMcclpimF3oDKQv84u1oCSJ8RYaW3c
        Tk47Jvoy8W05nBtcsTQ93pJgTeg+D1S6p8lO7UI=
X-Google-Smtp-Source: AGRyM1vOFkvS+zjURxCBbrk9p6gNNrG2//G5Qfx0s2IpKrnx9mB8JSCpqrL8DfNs7jrgpAgLFx5rH55K8wvFUvEJw1c=
X-Received: by 2002:a05:6a02:313:b0:416:73c:507c with SMTP id
 bn19-20020a056a02031300b00416073c507cmr4940522pgb.366.1659145102769; Fri, 29
 Jul 2022 18:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220727025255.61232-1-jrdr.linux@gmail.com> <8275d40f7154c3a4e4acc4d3779af38abb061df5.camel@redhat.com>
In-Reply-To: <8275d40f7154c3a4e4acc4d3779af38abb061df5.camel@redhat.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 30 Jul 2022 07:08:11 +0530
Message-ID: <CAFqt6zbeDLvnAb=r+b5t3aCO1t=01hJ=SknT9ye_rdWCEy5brg@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: microchip: remove of_match_ptr() from ksz9477_dt_ids
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
        Andrew Lunn <andrew@lunn.ch>, vivien.didelot@gmail.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 6:45 PM Paolo Abeni <pabeni@redhat.com> wrote:
>
> On Wed, 2022-07-27 at 08:22 +0530, Souptick Joarder wrote:
> > From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>
> >
> > > > drivers/net/dsa/microchip/ksz9477_i2c.c:89:34:
> > warning: 'ksz9477_dt_ids' defined but not used [-Wunused-const-variable=]
> >       89 | static const struct of_device_id ksz9477_dt_ids[] = {
> >          |                                  ^~~~~~~~~~~~~~
> >
> > Removed of_match_ptr() from ksz9477_dt_ids.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
>
> As this looks like a fix, could you please post a new revision of the
> patch including into the commit message a proper 'Fixes' tag?

Sure.
>
> Thanks!
>
> Paolo
>
