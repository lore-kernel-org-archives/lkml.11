Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425F6C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Feb 2022 21:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbiBLVDJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Feb 2022 16:03:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiBLVDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 16:03:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757DC606F1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 13:03:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A542B8070E
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 21:03:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466F1C340E7;
        Sat, 12 Feb 2022 21:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644699780;
        bh=soOkTierHC/obq+By1oORX6E7pYL9xn0OvQ3Pl07MRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YkWNDPVdJek00rYbRliXWhYfSq9MgbBZMhn1FB0kKrHKcfkMkfk/hQditzO1SWwQI
         j/UXqtnhjw/d4gzqIiGbwi6OiS+lEeLq+GmLNrJ3UTuH7vEzf45mw7XoJSPcbVBekF
         s8k77C6YcyffBBkd3l5ZrC0EjdCuBd08aIv/POICekPMVTq1KeJqKqdoN3jrGaJHJP
         GqWYli9SHfd9wJ/3CXjk8UWh27AyQqzcgeztgl2IDv9O67RzknnxUDnZ6gVWamYPgr
         Kv3mxSTFaxUPdS6dIXn4u/oMlqJ+tmkg9b/V6GhwleMbHfUBBV4Sw81Ai9PYgw6fBx
         rT1eXGRLOc3hA==
Date:   Sat, 12 Feb 2022 13:02:58 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Matt Waltz <matthewwaltzis@gmail.com>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: fix prp list allocation
Message-ID: <20220212210258.GA1660900@dhcp-10-100-145-180.wdc.com>
References: <20220212200649.541061-1-matthewwaltzis@gmail.com>
 <20220212204851.GA1660889@dhcp-10-100-145-180.wdc.com>
 <CABwBYcb0XhomznNOV62uH3Yo1J7XjHowuhF3H36owXtiVSp8JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABwBYcb0XhomznNOV62uH3Yo1J7XjHowuhF3H36owXtiVSp8JQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2022 at 01:53:59PM -0700, Matt Waltz wrote:
> That is the wrong part of the specification, describing the PRP entries,
> not the list pointer. 

The text for qword alignment rules specifically says "PRP List entry",
as is associated with command's prp2 field.

> The relevant portion of the spec (2.0a figure
> 109 page 129) says:
> 
>     If this entry is not the first PRP entry in the command or a
>     PRP List pointer in a command, then the Offset portion of this
>     field shall be cleared to 0h

That only applies to chaining list elements. It does not apply to the
"PRP list pointer in a command". The driver allocates from the 256B dma
pool only for the command's PRP list pointer, so we're fine.
