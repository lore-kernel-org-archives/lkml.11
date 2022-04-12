Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EEDC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 11:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346545AbiDLMAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 08:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239600AbiDLL5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:57:08 -0400
X-Greylist: delayed 318 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Apr 2022 03:43:49 PDT
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82FDF28
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:43:49 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Kd2J30hGhz9snG;
        Tue, 12 Apr 2022 12:38:27 +0200 (CEST)
Message-ID: <0f373548-2858-2e67-07eb-2763f4ac2a87@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1649759904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e8PY7GPjQD42x4v6SaG7ComMuVGBsLbkSNsoGN7tgio=;
        b=huN3jfTMAN3WF/YzcDwjoBpo6Wc/YOJq9bhGiahq+fp0Htjw97W36dvGqqrHIYJeGcM76u
        8s9xkpknNL2sZ7SQw3sBLyQjrbUuqyQrGOEl8TnbMZ95oC3VATLejoTYdCXyGwRiPTxwka
        BOTb6cOxswEdw0VhLC7yd76XxlHght15hX4zz3ioJ8yUdfEckPxT6ZyshxDHx4rHvFL5Dc
        BQyb6ZvS8CVbbDqY/m0/HB+c8V4LzRMYLfi1R6OTly+0nEwatGDmDnlj5Xq+F/obqwbH1V
        UdChI1WGVVjsmEaid3jqFZrGLT20zAygWb36vivZtjQX4mHZkBNDaGVWz7FrYQ==
Date:   Tue, 12 Apr 2022 12:38:13 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] dma-buf-map: remove renamed header file
Content-Language: en-CA
To:     Karol Herbst <kherbst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        dri-devel@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
References: <20220411134404.524776-1-kherbst@redhat.com>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <20220411134404.524776-1-kherbst@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-11 15:44, Karol Herbst wrote:
> commit 7938f4218168 ("dma-buf-map: Rename to iosys-map") already renamed
> this file, but it got brought back by a merge.
> 
> Delete it for real this time.
> 
> Fixes: 30424ebae8df ("Merge tag 'drm-intel-gt-next-2022-02-17' of git://anongit.freedesktop.org/drm/drm-intel into drm-intel-next")
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Karol Herbst <kherbst@redhat.com>
> ---
>  include/linux/dma-buf-map.h | 266 ------------------------------------
>  1 file changed, 266 deletions(-)
>  delete mode 100644 include/linux/dma-buf-map.h

Reviewed-by: Michel Dänzer <mdaenzer@redhat.com>


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer
