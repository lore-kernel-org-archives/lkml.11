Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13784C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Feb 2022 21:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiBLVB0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Feb 2022 16:01:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiBLVBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 16:01:24 -0500
Received: from biche.re (biche.re [IPv6:2607:5300:201:3100::6c88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73D2D3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 13:01:19 -0800 (PST)
Date:   Sat, 12 Feb 2022 22:01:12 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 biche.re 1396F40617
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=biche.re; s=biche;
        t=1644699675; bh=qt2OQlf2eNHyy4Rr7O8K2qYNm+v84dIqyVBhQttppkQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U21Qj3kMDmGoZPF/KMbRJsXuKvxZFM9PpKTRH5EzaUXVjSeMApeV+J9IEQHSEngUx
         tU1W7w8xnCPvl3HG7809KZw0NkxDNy+1e5EcjTG3in/rrIJ5fjkzd9DOhihFs0IK+2
         gQUnV3dgGTAQ7j5oB8V++TWPkCUw/9z751UgQyv01LjIrBs3pvVUfq+XpEHaGHMk6z
         nwRlnb9dIFcLu+kBBBAMfvs2gwSqYIokOAk7PHGsvdaOGYxBsYM26EEOL4wLTPEzo/
         9ec+nz+wDa7XcvOppD9fl3MCztZAHcbGmioavvo6+D9FPVAhfaEyOR8yqtYLzg8Sq+
         aKE0j7YV++Wsg==
From:   Victorien Molle <biche@biche.re>
To:     linux-kernel@vger.kernel.org
Cc:     Victorien Molle <biche@biche.re>
Subject: Re: [PATCH] KVM: x86: Add support for basic RAPL (Running Average
 Power Limit) metrics
Message-ID: <YgggGG92eMCzdomb@ultrahax>
References: <20220109182317.1075762-1-biche@biche.re>
 <YfKCLAdwh0LZXIDz@ultrahax>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfKCLAdwh0LZXIDz@ultrahax>
X-Operating-System: Winux 5.15.0-2-amd64 13.37
X-Message-Flag: Bonjour =?iso-8859-1?Q?=E0_toute?= =?iso-8859-1?Q?s?= les
 biches !
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping https://lore.kernel.org/all/20220109182317.1075762-1-biche@biche.re/T/#u
