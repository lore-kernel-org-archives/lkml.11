Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0DFC4167D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 20:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbiDFUIW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 16:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbiDFUHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:07:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2191EB80E;
        Wed,  6 Apr 2022 11:25:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 676D461BCB;
        Wed,  6 Apr 2022 18:25:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 668CDC385A1;
        Wed,  6 Apr 2022 18:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649269508;
        bh=h0Z0L0ZDGEbBQuk3WdHulXymIEd5ewd1ReemHmyCpJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mHKkp1ZA0QeEx3/Wtphc/0RuB65n17lCMQjfj9qrXDEsOd3rhwdRgI37gaPr7IAaC
         /AJkCqRH94OcnsNHp1Kf7dNRBOeEaVXmrLdl4IsqgWz1p7drBDI2jGJ1Mf8Nn5q8Ga
         D94kkQZuqQDmxUsFiXno1w+jpX3hVESkNWfwc8Co=
Date:   Wed, 6 Apr 2022 20:23:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     James Morse <james.morse@arm.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [stable:PATCH v4.9.309 00/43] arm64: Mitigate spectre style
 branch history side channels
Message-ID: <Yk3av5Vv5kvfv1Nl@kroah.com>
References: <20220406164217.1888053-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406164217.1888053-1-james.morse@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 05:41:34PM +0100, James Morse wrote:
> Hello!
> 
> Compared to the v4.14 backport, this backport for v4.9 includes extra
> infrastructure for the arch timer driver, which is needed for the A76 timer
> workaround, which is needed to cleanly pick up the A76 MIDR definition.
> I didn't backport the Hisilicon 161010101 workaround as I'm unable to test it.
> 
> I also backported the capabilities midr-range support, which the bhb
> mitigation makes use of. Ard had already backported this to v4.14.
> I ended up backporting Ard's version from v4.14 as it conflicted less,
> and he had added A35 to the spectre-safe list.
> 
> .. and then the Spectre-BHB bits, where as before the KVM stuff is
> different to mainline as the infrastructure for doing this stuff is very
> different.

Looks great, many thanks for these!

greg k-h
