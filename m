Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE25C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 May 2022 07:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389414AbiEFHOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 May 2022 03:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389409AbiEFHOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:14:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB1966F92
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 00:10:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4AA4F21A32;
        Fri,  6 May 2022 07:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651821055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9iobKkEjSGTbzqIJvKfuI7vLuxiRZWSHjoZywPn+nWM=;
        b=JLzFkU7xwY1ZjXdLarT8pGQVzBIanoEu2BZbq3GvSexWXwgPNyG7Mkxun4xI0NgKpH107P
        Hh3QQVAdxF9bEDkBDQRgc6gf4nmsFNS9GuZUy06M3mpIXiyhI1BQ3+HXriMBlC3nr/s3bm
        kiKb8ot+qoRNGjwe0dokvV6yCj8ZQZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651821055;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9iobKkEjSGTbzqIJvKfuI7vLuxiRZWSHjoZywPn+nWM=;
        b=SxdCT94BeiSi1w3l3sLoYE1hGpncMHwq5a+oiwnWXz0ke41qMs8opB1mVjp0SNPToo7kA/
        uC5lgdhQHpQ+8gBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E418413AA2;
        Fri,  6 May 2022 07:10:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id osEbNv7JdGIhHwAAMHmgww
        (envelope-from <jroedel@suse.de>); Fri, 06 May 2022 07:10:54 +0000
Date:   Fri, 6 May 2022 09:10:53 +0200
From:   "Rodel, Jorg" <jroedel@suse.de>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Kyung Min Park <kyung.min.park@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will@kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/vt-d: Increase DMAR_UNITS_SUPPORTED
Message-ID: <YnTJ/YqQpru3YPC+@suse.de>
References: <20220505194658.246121-1-steve.wahl@hpe.com>
 <e2afd89c-b1cf-9fde-4ce2-4be3c1fdaf07@linux.intel.com>
 <BN9PR11MB5276F4D5F8AD33293233B9AB8CC59@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN9PR11MB5276F4D5F8AD33293233B9AB8CC59@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2022 at 06:49:43AM +0000, Tian, Kevin wrote:
> another nit: dmar is intel specific thus CONFIG_X86 is always true.

There are Itanium systems which have DMAR units. Is that no longer
supported?

Regards,

-- 
Jörg Rödel
jroedel@suse.de

SUSE Software Solutions Germany GmbH
Maxfeldstr. 5
90409 Nürnberg
Germany
 
(HRB 36809, AG Nürnberg)
Geschäftsführer: Ivo Totev

