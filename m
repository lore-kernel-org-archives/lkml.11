Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B41C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Feb 2022 07:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiB1HIt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Feb 2022 02:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiB1HIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 02:08:47 -0500
Received: from mailrelay.tugraz.at (mailrelay.tugraz.at [129.27.2.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2135660ABB
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 23:08:07 -0800 (PST)
Received: from [192.168.0.150] (84-115-212-199.cable.dynamic.surfer.at [84.115.212.199])
        by mailrelay.tugraz.at (Postfix) with ESMTPSA id 4K6Wg75JVBz3xVf;
        Mon, 28 Feb 2022 08:08:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tugraz.at;
        s=mailrelay; t=1646032083;
        bh=+JW2ocuDNtQZWRPsfo4murD1s5BVXtRPB2waQk8WwMk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=hKEwIYsCo7sbSCMFB1sptFjNojejP+SEikz70Lk+S/NwjhxT08MPoY/Soog2UeoJp
         30c67OaZMnxz598DJU7e9h02vc9+csDp42INRhy1lZsqbsHZrjjnVvN98G0mmlCRCd
         LoaX51sMeJ1HUd6wPDBgS5J9A0hCJhtzLNST5FJI=
Message-ID: <dc52af7ebc044c94337e138f6e1ae807559b4825.camel@tugraz.at>
Subject: Re: [RFC PATCH 03/13] usb: remove the usage of the list iterator
 after the loop
From:   Martin Uecker <uecker@tugraz.at>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 28 Feb 2022 08:08:03 +0100
In-Reply-To: <CANiq72k_PUBPVL1Fx4HLm_WO66RuSsi0oSsKRhssCYRNGbY84Q@mail.gmail.com>
References: <CAHk-=wjtZG_0zjgVt0_0JDZgq=xO4LHYAbH764HTQJsjHTq-oQ@mail.gmail.com>
         <bd43bd47c8eaa4c22c1a1549cee66f7ef960b1fc.camel@med.uni-goettingen.de>
         <CAHk-=whFMxks63sfMQ-0_YO1GsTmoLfsO4ciMtoiCHNgaG_+GA@mail.gmail.com>
         <979af7ae9b7e8baf080ef6f8d42d48d7f5d2c5b4.camel@tugraz.at>
         <CANiq72k_PUBPVL1Fx4HLm_WO66RuSsi0oSsKRhssCYRNGbY84Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TUG-Backscatter-control: G/VXY7/6zeyuAY/PU2/0qw
X-Scanned-By: MIMEDefang 2.74 on 129.27.10.117
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, den 27.02.2022, 19:12 +0100 schrieb Miguel Ojeda:
> On Sat, Feb 26, 2022 at 3:43 AM Martin Uecker <uecker@tugraz.at> wrote:
> > Roughly the same group of people / companies that
> > write the compilers also control what goes into the
> > standard. They then like to point to the standard
> 
> Indeed, at least to a substantial degree.
> 
> > For signed overflow, I am not entirely sure what the
> > right choice is.  Wrapping for signed overflow also seems
> > dangerous. I use UBsan to find such issues in my code, and
> > this would not really work if signed overflow was defined
> > to wrap.
> 
> UBsan and similar tooling may still be used to find whatever behavior
> one wants, whether defined or not. UBSan already has non-UB checks.

Technically, this is true but not really in practice. If signed
overflow would be defined to wrap, then code would start to
rely on it and detecting it becomes useless because there are
too many false positives.  In your own small controlled code 
base it could work though.

Martin

