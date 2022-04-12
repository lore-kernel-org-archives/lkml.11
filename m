Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6817C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 16:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357898AbiDLRBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 13:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350604AbiDLRB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 13:01:28 -0400
X-Greylist: delayed 397 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Apr 2022 09:59:09 PDT
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B3CCC5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 09:59:08 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4KdBbf3jHxzDrNK;
        Tue, 12 Apr 2022 09:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1649782350; bh=mqIkrmMc3bt9SF6MVOjnFO/Z9nRa+OeF8I4cZ4B5EqM=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=SQnwxSdFaRv0TpSyDqeAtShH/Crkg4pUtCFYAMnJ1ElyLjqNaZripECStyfCMgKFG
         vp/udeHjSlEsLCBwyRULLhVZ2+WKPwPFVGcPbrwczGTJPXQiSzWJ73SZ5MmTDHTH3c
         642ut0tljgwH1GS6+vCt9ZHFU9cxlWvxuDThVirA=
X-Riseup-User-ID: 326DD260AC5C707B7ABD8D7E28AE5FD39250B3D2E2B8BE61D0BE289715F30496
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4KdBbb3Bw1z5vLq;
        Tue, 12 Apr 2022 09:52:27 -0700 (PDT)
Message-ID: <166f88cd-80aa-ea6c-9503-f15ba7b8da89@riseup.net>
Date:   Tue, 12 Apr 2022 13:52:24 -0300
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] drm/vkms: check plane_composer->map[0] before using
 it
Content-Language: en-US
To:     Tales Lelo da Aparecida <tales.aparecida@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220411233801.36297-1-tales.aparecida@gmail.com>
 <20220411233801.36297-2-tales.aparecida@gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@riseup.net>
In-Reply-To: <20220411233801.36297-2-tales.aparecida@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tales,

Às 20:38 de 11/04/22, Tales Lelo da Aparecida escreveu:
> Fix a copypasta error, which resulted in checking repeatedly if the
> primary_composer->map[0] was null, instead of checking each
> plane_composer while composing planes.
> 
> Signed-off-by: Tales Lelo da Aparecida <tales.aparecida@gmail.com>

Reviewed-by: André Almeida <andrealmeid@riseup.net>
