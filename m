Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46203C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Feb 2022 23:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236831AbiBRXHx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Feb 2022 18:07:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235363AbiBRXHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 18:07:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442F95AECF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 15:07:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF533B82677
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 23:07:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581CAC340E9;
        Fri, 18 Feb 2022 23:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645225651;
        bh=5tvre9+be3n04DFPNwxXq80/EJVN+yhMVA7ExsDuacM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=stM3YoCUjzizuAYk82bXE1DW1eS1OGoKRAldTUJFE3jhePXwAr3h4tXU6xs2tfl9a
         ebAMlveHnHvQAeut1TlwmpOWFssEdnJJ4Sqiw6/joWI9ecYg8GXNZwz1tBINwdT3xd
         fVpChmRCPkcXnXtzPL79UfEQGZciUvq5EeCopiNI1qgyFRnPxm6azI/mUB6VNcsIta
         WQhmgpIQdA/VQp3V5wIzUB/yuVu5pIZJLp79WA45REy6gywLgi9bRHnKgKlN78nua7
         V82VLdcFfHCsPuDFdLp18kCNXSWn6q9eVivpdDeJ3P+czJGFwfQdb93l2GvuWycCUu
         vNWpwb79vu6Xw==
Date:   Fri, 18 Feb 2022 17:15:16 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: fallthrough question
Message-ID: <20220218231516.GA1091555@embeddedor>
References: <858a2b13-64e1-99bc-e2f7-5b2477bb1126@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <858a2b13-64e1-99bc-e2f7-5b2477bb1126@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

On Fri, Feb 18, 2022 at 01:57:58PM -0800, Randy Dunlap wrote:
> Hi,
> 
> I expected this to produce a fallthrough warning, but it doesn't
> (with gcc 11.1.0):
> 
> from sound/oss/dmasound/dmasound_core.c:#1481, when falling from case 1
> into case 0: (in arch/m68k/ selected builds only)
> 
> 	case 1:
> 		if ((size = ints[2]) < 256) /* check for small buffer specs */
> 			size <<= 10 ;
>                 if (size < MIN_BUFSIZE || size > MAX_BUFSIZE)
>                         printk("dmasound_setup: invalid write buffer size, using default = %d\n", writeBufSize);
>                 else
>                         writeBufSize = size;
> 	case 0:
> 		break;
> 	default:
> 
> Can you tell me what is going on here?

As you can see the warning is suppressed when a case label falls through to
a case that merely breaks... or returns, or continues (continue statement)
or that goes to (goto statement) some other place.

However, Clang disagrees with this. See below for more:

https://github.com/ClangBuiltLinux/linux/issues/636
https://godbolt.org/z/xgkvIh

--
Gustavo
