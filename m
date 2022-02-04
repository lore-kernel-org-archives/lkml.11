Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBADCC433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Feb 2022 17:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377001AbiBDRmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Feb 2022 12:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbiBDRmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 12:42:11 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3A4C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 09:42:10 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id o16-20020a17090aac1000b001b62f629953so13741403pjq.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 09:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mw2mTYd1EA4mqj3Y4u5Ue6ccwfT5N3jmz03Fjl83bCU=;
        b=eXZ63+a1lsDWDQRsOLXVJsnfLq/T94bBQbtG2VSM6hWcEGd2c3kiVmPhjjtYB+R676
         rkEaPFYX5U1ven+VCgHmCha20Y8LYxpO/9S1b0kb/WWLCJZpKi7BFo4nhuGxkJCc9GRe
         Puco1/iHoAktkjG+LtLJSXWG9EvmSm+TWXyIRyNhWGugQ6CONuWNsjJuCk2QWXRVYkf3
         FxCJr8VaU/Kbk74pf8WcRIrlxRF7QNpAHc0a8lyHU+OSMfEDVJRQVcg5jMeZWoPyYz9L
         Oa0PYy4YemePwGFF1YbLDQiBLoaeD7Ig9LLQs1HK8Jdk9XMWExOtIpMlEFakXV58Loca
         l3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mw2mTYd1EA4mqj3Y4u5Ue6ccwfT5N3jmz03Fjl83bCU=;
        b=owrFD5J+41RKCQzH/tfeYk1TvRMg38nkub9UD0BowXNuzfyxmzUV3Bsg5N6aRd/LXJ
         1eTm/RHLp6DkWjIOqtnwJJTHD+TqFF6jiplK4IDj5Fmz0JojvrxPFqwmbWP0JooJK9N+
         Th4YWoLFB4iyVnB+qHByBHxoxYYZgdwNb6gTTHub2eLkrlfuOd9TweBNUKTcq4tWZRAt
         i3Mh4VAiQ8+56n/Pt6q9Vyepka1l73s72wZLXDUsZ8pWWWa2RAuRFdOkSN9/jbARKl8W
         dsPuITd8/hEC4/oT4rFHsfgw7MPGf/gal/IglX9yUHclSn5yKWYs89r1cZDgSHG8whKM
         0rXQ==
X-Gm-Message-State: AOAM530Hp7RiipifRCfRDwLVZap/DY765XQ2n1QVWWaMroqiYUPwvd1m
        JK5PIAwZm9eH01s/gnZ2oa1s4pxfL4avnh+EIVUaHg==
X-Google-Smtp-Source: ABdhPJzLGEd34xTTZiapGHY+mhMUMcd8jfGKSDZbIobWC3HUsXScKTdFqfNyjqr9T/g005FzIwmAT/68aOu7KH0LPSA=
X-Received: by 2002:a17:902:d705:: with SMTP id w5mr4408362ply.34.1643996530392;
 Fri, 04 Feb 2022 09:42:10 -0800 (PST)
MIME-Version: 1.0
References: <20220127175505.851391-1-ira.weiny@intel.com> <20220127175505.851391-38-ira.weiny@intel.com>
In-Reply-To: <20220127175505.851391-38-ira.weiny@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 4 Feb 2022 09:41:59 -0800
Message-ID: <CAPcyv4go5pqWdvR7w7kDjOKQywTUwZ=Tbn-LSmOyE-4GdhZsmg@mail.gmail.com>
Subject: Re: [PATCH V8 37/44] memremap_pages: Set PKS PKey in PTEs if
 PGMAP_PROTECTIONS is requested
To:     "Weiny, Ira" <ira.weiny@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 9:55 AM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> When the user requests protections the dev_pagemap mappings need to have
> a PKEY set.
>
> Define devmap_protection_adjust_pgprot() to add the PKey to the page
> protections.  Call it when PGMAP_PROTECTIONS is requested when remapping
> pages.
>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---

Does this patch have a reason to exist independent of the patch that
introduced devmap_protection_enable()?

Otherwise looks ok.
