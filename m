Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B21CCA48C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jun 2022 17:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbiFXR1n (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jun 2022 13:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiFXR0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:26:33 -0400
Received: from mailrelay3-1.pub.mailoutpod1-cph3.one.com (mailrelay3-1.pub.mailoutpod1-cph3.one.com [46.30.210.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C73B3E5C3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=kKMlyigldhqIKPtpc/HTqH04jpVCEZ2Uj0a4oEjScvQ=;
        b=dIA3UtO+bXXsFoKsMM0zNGq/QbMHWhMKuOUXmdH/rpWNjFyzQ1vjr2mVb5N4luMF5COD6CTVfL4ns
         XGIBNrsFu/MMsa4mT8ZA4r3qDWOphUd/pohvpRRqf4e04OEqMQI7SHeLwQ8XALQiZbEAl7xUMJSs66
         w5zFIwoMAonePdbtTee1VWU1YIkgHnQy5H79bw6+gBKPApudhvfaM9wIplEAu0BGXD+oVwDJHlV1lj
         FzHWi6ahSNz+XXvWUHP9jw/UCEhRtUFgp2Qi3/RPrOqTfRElYgnPqLF4aLqppmilZCYXtpUKweuysA
         YXhcgzSbpjGFbTwPCcfyQfO1yg+aUUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=kKMlyigldhqIKPtpc/HTqH04jpVCEZ2Uj0a4oEjScvQ=;
        b=pLODzhr0ICxTTRSGGUxLlQi1uSu5F7stxjTe16GEavcTvW1IQRWBpn+FmDm9BS24Wy30B/Vui9P6a
         ZziOKxODw==
X-HalOne-Cookie: ac4d69d102f6ad701fef4aaa0f761458036f703e
X-HalOne-ID: bd268857-f3e2-11ec-be7c-d0431ea8bb03
Received: from mailproxy3.cst.dirpod4-cph3.one.com (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id bd268857-f3e2-11ec-be7c-d0431ea8bb03;
        Fri, 24 Jun 2022 17:26:10 +0000 (UTC)
Date:   Fri, 24 Jun 2022 19:26:08 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Philip Oberfichtner <pro@denx.de>
Cc:     devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        matthias.winker@de.bosch.com, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [RESEND v5 1/2] dt-bindings: display: simple: Add DataImage
 FG1001L0DSSWMG01 compatible string
Message-ID: <YrXzsK9JE8At8WL/@ravnborg.org>
References: <20220623112257.4178461-1-pro@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220623112257.4178461-1-pro@denx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philip,

On Thu, Jun 23, 2022 at 01:22:56PM +0200, Philip Oberfichtner wrote:
> Add DataImage FG1001L0DSSWMG01 10.1" 1280x800 TFT LCD panel compatible
> string.
> 
> Signed-off-by: Philip Oberfichtner <pro@denx.de>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Both patches applied to drm-misc (drm-misc-next)

	Sam
