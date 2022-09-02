Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A5CC6FA85
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Sep 2022 05:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbiIBF4S (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Sep 2022 01:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbiIBF4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 01:56:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30374D167
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 22:55:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F3D6B829E1
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 05:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A2BC433B5;
        Fri,  2 Sep 2022 05:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662098129;
        bh=1TFOSeFUslgObcTNBOkzRO2aJyYzjTZ+POXZAASLeQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HObci4PZ2uDOVeAI1+swxi8TUo+3vAYi3QBNJJGeyWZjktrioSXqltrL8tHc8oD40
         TZi9sZtvRIjo6XG+R1t6VrtFYu6EkjwPy5FaSI/JS5r9W9RjQ9iHbMmjgh9+TauG6j
         d2PumfVY+gvYXIM7zmlgExjFeC0ki419CRTr3oe4=
Date:   Fri, 2 Sep 2022 07:55:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Biederman <ebiederm@xmission.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH v3 1/1] kernel/utsname_sysctl.c: Print kernel arch
Message-ID: <YxGazit2XS/YZlZZ@kroah.com>
References: <20220901194403.3819-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901194403.3819-1-pvorel@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 09:44:03PM +0200, Petr Vorel wrote:
> Print the machine hardware name (UTS_MACHINE) in /proc/sys/kernel/arch.
> 
> This helps people who debug kernel with initramfs with minimal
> environment (i.e. without coreutils or even busybox) or allow to open
> sysfs file instead of run 'uname -m' in high level languages.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
