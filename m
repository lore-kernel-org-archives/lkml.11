Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A96C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 May 2022 14:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238867AbiEJO6P (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 May 2022 10:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345510AbiEJO40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:56:26 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062A22802C9;
        Tue, 10 May 2022 07:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652192241; x=1683728241;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=BOBfGKDZ3o7R/t5ac+GRsDT4rIxltWL77PvfKQdlDpU=;
  b=XkLpqGwBjcwKRip86uS2RJHVd0OlIcdkPyvsMA3mxdXNFO/F0Dn/IjR9
   PpavgYnjtWO3aFm9W+CjklGrZOG0NkBSThq0aq/Tx6UDTM/IDyYVg1oyP
   5IFUZcxBw2A02rR/K72XZlRsFMExiXcsfk4YuKg6eQtRxXin6xgnI/a4o
   ds2Hdb8QW2Nro3SN+9ayPkyvDA38nCEWMOnInDSx2okHWDfw2S8ptFbXB
   dZ01i/wNIhCUEjWj0GCNpie7SwydS465mPGCYLGNvNMu/O+Wn0KzZqMDS
   GaM9O6Sp3Jv84e18JLqrKA1MzuB2eEmC8ITtaYjRmukHqybpbHmo7QRPl
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="269049136"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="269049136"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 07:17:04 -0700
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="813993242"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 07:17:03 -0700
Date:   Tue, 10 May 2022 07:16:56 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
cc:     dinguyen@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v4 1/3] dt-bindings: soc: add bindings for Intel HPS Copy
 Engine
In-Reply-To: <e14122b9-cd7a-b2a9-93a5-cde6139969c1@linaro.org>
Message-ID: <alpine.DEB.2.22.394.2205100715570.612063@rhweight-WRK1>
References: <20220508142624.491045-1-matthew.gerlach@linux.intel.com> <20220508142624.491045-2-matthew.gerlach@linux.intel.com> <e14122b9-cd7a-b2a9-93a5-cde6139969c1@linaro.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 9 May 2022, Krzysztof Kozlowski wrote:

> On 08/05/2022 16:26, matthew.gerlach@linux.intel.com wrote:
>> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>>
>> Add device tree bindings documentation for the Intel Hard
>> Processor System (HPS) Copy Engine.
>>
>> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Hi Krzysztof,

Thank you for the review.  I will add your tag and submit a v5 patchset.

Matthew
>
>
> Best regards,
> Krzysztof
>
