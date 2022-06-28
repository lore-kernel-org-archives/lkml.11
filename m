Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C2BC43334
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 20:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiF1Ugs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jun 2022 16:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiF1Ugq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 16:36:46 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9835E1CFFD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:36:45 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id x184so21485499ybg.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=Am+buBS6l9nDliYi+u6nlrkdsgJwYS/B4MsYLVetbz0=;
        b=D+OVeNm+qvlXxecJvzQgMO+iI5wnx/Q+mmwN4AY3Lk+s3B2SwNd9P1y9S+PGzcyFzV
         bZ1n9262BipKLcCfsy4kigvYQiheYVnfgCmWcUusxVNPE8tgJyqzmmqyPg7q0YPoP8XY
         sBQEeSytPIU4FhSXkTuxZD7+ddIgxI9Z4hmeZx1r4LjPVE1+/forNrC+qxY0COQ3b9sh
         Se0VL0Mt/Dq6iiq1HzWEFJFk9ja+BIEK2KeOdGZ0nPsapflE8jJ413qa6OxkupFS9vxD
         vgra8Hzvb9AurSik+ryWVWxUcUl42un9D7jR8K4f8O+BkBDMrpDOiBHclho6e8A6qPct
         g2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Am+buBS6l9nDliYi+u6nlrkdsgJwYS/B4MsYLVetbz0=;
        b=gAV0d7atoTxZgj1uMxjSEKyippuxCRR5vw//jmVdDKDUrE8V3o+SCTOme0pbEEHwh3
         kIGpK+E9I4Y/lrGjP/iYtgMkVPWG0Puf56b8wrDd8LrH03JgO0Zrn/dsOY3mMdY2Oiw/
         ZlBdv90aHaX91OZ+s1QOsIZk5s4+83i2TPIz3c+MuO0bTb2IeWQqozVompZrbCOP5AIt
         OriytDDF5rT8XUhYCcWhOzFb6x9uhzpjwz2fgjja5VUAAjl9FLxvsnKU6B4IKbdLF54o
         1CRB8ihRybesPwOdvpO4yAfqHZZ/1QMbeO+S/qj+aQuPFNT3oDtEOiuJHVjoj00lACOE
         AFcw==
X-Gm-Message-State: AJIora97ENZezt/kDHS9fipJFXbepq+E81I1jfWKkF+aMe9YviL+Bq3s
        AqrvRgntXs/80O4rMPKC1qQEgq0XxGvgf/PlLZg=
X-Google-Smtp-Source: AGRyM1s5E4nHxae1yrblcbA4tTqiFMh24HYtR3/tjtzturQ07ZM7iIEDC9rbqQPZlZI5e3z6g50bhHP7kYzrpMPKrq8=
X-Received: by 2002:a5b:f43:0:b0:665:6ff:c70b with SMTP id y3-20020a5b0f43000000b0066506ffc70bmr21793547ybr.216.1656448604796;
 Tue, 28 Jun 2022 13:36:44 -0700 (PDT)
MIME-Version: 1.0
From:   Joe R <joelinux1992@gmail.com>
Date:   Tue, 28 Jun 2022 16:36:34 -0400
Message-ID: <CANmBqSDd-n2gyvkDgAqOO_Q43dRodrS9_BFmkxDY27O87p=Q=Q@mail.gmail.com>
Subject: Re: [PATCH] wireguard: selftests: support OpenRISC
To:     openrisc@lists.librecores.org, linux-kernel@vger.kernel.org,
        shorne@gmail.com, Jason@zx2c4.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the patch, it seems like you put in a lot of time into it.

However, I do have one question: on the website
(https://www.wireguard.com/build-status/) it says that the test is
still failing. Is that due to the QEMU changes that have yet to be
upstream, or is it outdated and has already been fixed?

Thanks again for all the hard work you do!
