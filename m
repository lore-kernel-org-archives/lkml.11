Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4EAC43334
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jun 2022 10:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241284AbiFMKMu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jun 2022 06:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241348AbiFMKMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 06:12:40 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4C6F08;
        Mon, 13 Jun 2022 03:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xbSS6/wiDH/1RkoIqjpuk8UPCrRb3ic63i+lK3L+h/Y=;
  b=ZQ457tF97m5mn6CMi7t5HVWoScnKbwtSSgkgmV4i8qd6jDKaF1OM4/iY
   XsvbYSJQZSbphS+NqBc22dkJxFafFZ1GaTTCdrWGPb1Chv8UWoz+Lij6E
   bh2lOb+K9jZxdTcO5vt/HCR+w31RcF/r7lAHbovMi5ntPymrWAwBqLIQr
   8=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,297,1647298800"; 
   d="scan'208";a="40717374"
Received: from 245.122.68.85.rev.sfr.net (HELO hadrien) ([85.68.122.245])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 12:12:32 +0200
Date:   Mon, 13 Jun 2022 12:12:31 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Bagas Sanjaya <bagasdotme@gmail.com>
cc:     Dongliang Mu <dzm91@hust.edu.cn>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Jonathan Corbet <corbet@lwn.net>,
        Dongliang Mu <mudongliangabcd@gmail.com>, cocci@inria.fr,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dev-tools: fix one invalid url
In-Reply-To: <Yqbu8TwmaXdBiIBs@debian.me>
Message-ID: <alpine.DEB.2.22.394.2206131212160.2812@hadrien>
References: <20220613071243.12961-1-dzm91@hust.edu.cn> <Yqbu8TwmaXdBiIBs@debian.me>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Jun 2022, Bagas Sanjaya wrote:

> On Mon, Jun 13, 2022 at 03:12:42PM +0800, Dongliang Mu wrote:
> > From: Dongliang Mu <mudongliangabcd@gmail.com>
> >
> > Fix the invalid url about Semantic Patch Language
> >
>
> I think what this patch doing is to point SPL reference URL from old
> Coccinelle documentation (doc root) to actual SPL doc entry on new
> Coccinelle page, right? If so, "fix invalid URL" may not be right patch
> description and title.

Agreed, thanks for the suggestion.

julia
